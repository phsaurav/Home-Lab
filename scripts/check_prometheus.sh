#!/bin/bash

###############################################################################
# Prometheus Health Check Script
# Description: Tests Prometheus metrics and scrape targets
###############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROM_PORT=32090
NAMESPACE="monitoring"

###############################################################################
# Helper Functions
###############################################################################

print_header() {
    echo ""
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║ $1${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

###############################################################################
# Main Script
###############################################################################

print_header "PROMETHEUS HEALTH CHECK"

# Get Node IP
print_info "Getting Kubernetes node IP..."
NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')

if [ -z "$NODE_IP" ]; then
    print_error "Failed to get node IP"
    exit 1
fi

print_success "Node IP: $NODE_IP"
PROM_URL="http://${NODE_IP}:${PROM_PORT}"
print_info "Prometheus URL: $PROM_URL"

###############################################################################
# 1. Basic Health Checks
###############################################################################

print_header "1. BASIC HEALTH CHECKS"

# Check if Prometheus is healthy
print_info "Checking Prometheus health..."
if curl -s "${PROM_URL}/-/healthy" > /dev/null 2>&1; then
    print_success "Prometheus is healthy"
else
    print_error "Prometheus is not healthy"
    exit 1
fi

# Check if Prometheus is ready
print_info "Checking Prometheus readiness..."
if curl -s "${PROM_URL}/-/ready" > /dev/null 2>&1; then
    print_success "Prometheus is ready"
else
    print_error "Prometheus is not ready"
    exit 1
fi

# Check if Prometheus is scraping itself
print_info "Checking if Prometheus is scraping itself..."
PROM_UP=$(curl -s "${PROM_URL}/api/v1/query?query=up{job=\"prometheus\"}" | jq -r '.data.result[0].value[1]')
if [ "$PROM_UP" == "1" ]; then
    print_success "Prometheus is scraping itself (up=1)"
else
    print_error "Prometheus is not scraping itself (up=$PROM_UP)"
fi

###############################################################################
# 2. Scrape Targets Status
###############################################################################

print_header "2. SCRAPE TARGETS STATUS"

print_info "Fetching all scrape targets..."
TARGETS=$(curl -s "${PROM_URL}/api/v1/targets" | jq -r '.data.activeTargets[] | "\(.labels.job)|\(.labels.instance)|\(.health)"')

if [ -z "$TARGETS" ]; then
    print_warning "No active targets found"
else
    echo ""
    printf "%-30s %-40s %-10s\n" "JOB" "INSTANCE" "STATUS"
    echo "─────────────────────────────────────────────────────────────────────────────────"
    
    while IFS='|' read -r job instance health; do
        if [ "$health" == "up" ]; then
            printf "${GREEN}%-30s %-40s %-10s${NC}\n" "$job" "$instance" "✓ $health"
        else
            printf "${RED}%-30s %-40s %-10s${NC}\n" "$job" "$instance" "✗ $health"
        fi
    done <<< "$TARGETS"
    echo ""
fi

###############################################################################
# 3. Metrics Availability Check
###############################################################################

print_header "3. METRICS AVAILABILITY"

# Get total metrics count
print_info "Counting total available metrics..."
TOTAL_METRICS=$(curl -s "${PROM_URL}/api/v1/label/__name__/values" | jq '.data | length')
print_success "Total metrics available: $TOTAL_METRICS"

echo ""

# Check kube-state-metrics
print_info "Checking kube-state-metrics..."
KUBE_NODE_INFO=$(curl -s "${PROM_URL}/api/v1/query?query=kube_node_info" | jq '.data.result | length')
if [ "$KUBE_NODE_INFO" -gt 0 ]; then
    print_success "kube_node_info: $KUBE_NODE_INFO results"
else
    print_error "kube_node_info: No data (kube-state-metrics may not be running)"
fi

KUBE_POD_INFO=$(curl -s "${PROM_URL}/api/v1/query?query=kube_pod_info" | jq '.data.result | length')
if [ "$KUBE_POD_INFO" -gt 0 ]; then
    print_success "kube_pod_info: $KUBE_POD_INFO results"
else
    print_error "kube_pod_info: No data"
fi

# Check node-exporter
print_info "Checking node-exporter..."
NODE_CPU=$(curl -s "${PROM_URL}/api/v1/query?query=node_cpu_seconds_total" | jq '.data.result | length')
if [ "$NODE_CPU" -gt 0 ]; then
    print_success "node_cpu_seconds_total: $NODE_CPU results"
else
    print_error "node_cpu_seconds_total: No data (node-exporter may not be running)"
fi

NODE_MEMORY=$(curl -s "${PROM_URL}/api/v1/query?query=node_memory_MemTotal_bytes" | jq '.data.result | length')
if [ "$NODE_MEMORY" -gt 0 ]; then
    print_success "node_memory_MemTotal_bytes: $NODE_MEMORY results"
else
    print_error "node_memory_MemTotal_bytes: No data"
fi

# Check cAdvisor (container metrics)
print_info "Checking cAdvisor (container metrics)..."
CONTAINER_MEM=$(curl -s "${PROM_URL}/api/v1/query?query=container_memory_usage_bytes" | jq '.data.result | length')
if [ "$CONTAINER_MEM" -gt 0 ]; then
    print_success "container_memory_usage_bytes: $CONTAINER_MEM results"
else
    print_error "container_memory_usage_bytes: No data"
fi

###############################################################################
# 4. Dashboard Required Metrics
###############################################################################

print_header "4. DASHBOARD REQUIRED METRICS"

# Check critical metrics for the Grafana dashboard
DASHBOARD_METRICS=(
    "kube_node_info"
    "kube_pod_container_resource_requests"
    "kube_pod_container_resource_limits"
    "kube_pod_status_phase"
    "node_cpu_seconds_total"
    "node_memory_MemTotal_bytes"
    "container_cpu_usage_seconds_total"
    "container_memory_working_set_bytes"
)

echo ""
MISSING_COUNT=0

for metric in "${DASHBOARD_METRICS[@]}"; do
    COUNT=$(curl -s "${PROM_URL}/api/v1/query?query=${metric}" | jq '.data.result | length')
    if [ "$COUNT" -gt 0 ]; then
        print_success "$metric: ✓ Available ($COUNT results)"
    else
        print_error "$metric: ✗ Missing"
        ((MISSING_COUNT++))
    fi
done

###############################################################################
# 5. Pod Status Check
###############################################################################

print_header "5. MONITORING PODS STATUS"

print_info "Checking monitoring namespace pods..."
echo ""
kubectl get pods -n $NAMESPACE -o wide

###############################################################################
# 6. Summary
###############################################################################

print_header "SUMMARY"

echo ""
if [ "$MISSING_COUNT" -eq 0 ]; then
    print_success "All dashboard metrics are available!"
    print_success "Your Prometheus setup is ready for the Grafana dashboard."
else
    print_error "$MISSING_COUNT dashboard metric(s) are missing"
    print_warning "You may need to deploy:"
    if [ "$NODE_CPU" -eq 0 ]; then
        echo "  - node-exporter (for node_* metrics)"
    fi
    if [ "$KUBE_NODE_INFO" -eq 0 ]; then
        echo "  - kube-state-metrics (for kube_* metrics)"
    fi
fi

echo ""
print_info "Access URLs:"
echo "  Prometheus: $PROM_URL"
echo "  Grafana:    http://${NODE_IP}:32300"
echo ""
print_info "Prometheus Targets: ${PROM_URL}/targets"
print_info "Prometheus Graph:   ${PROM_URL}/graph"
echo ""

