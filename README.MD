
# Payment System Setup (Open-Source Version)

This project sets up a payment system using open-source technologies including Traefik, Keycloak, Kafka, PostgreSQL, Fraud-AR, Kannel, Superset, Prometheus, and Grafana.

## System Overview

This system comprises the following services:

1. **Traefik (API Gateway)**: Routes traffic and manages SSL termination.
2. **Keycloak (Authentication Service)**: Handles user authentication and authorization.
3. **Kafka (Message Broker)**: For asynchronous communication between services.
4. **PostgreSQL (Database)**: Stores transaction data, user information, and more.
5. **Fraud-AR (Fraud Detection)**: Detects and flags fraudulent transactions.
6. **Kannel (SMS Notifications)**: Sends SMS notifications to users for payment-related events.
7. **Superset (Reporting & Analytics)**: Provides reporting and dashboards for transaction data.
8. **Prometheus (Monitoring)**: Collects system metrics and service health data.
9. **Grafana (Visualization)**: Visualizes metrics collected by Prometheus.

## Prerequisites

- **Docker** and **Docker Compose** must be installed on your machine.

## Setup Instructions

### Step 1: Clone the Repository

Clone the repository from GitHub (or create your own):

```bash
git clone git@github.com:<your-github-username>/payment-system.git
cd payment-system
