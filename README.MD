# Payment System

## Overview

The **Payment System** is a modular and scalable architecture designed to handle payment processing, merchant management, fraud detection, notification services, and more. The system is built using **microservices** for each critical function, allowing independent teams to work on different parts of the system while maintaining flexibility and scalability.

Each service is containerized using **Docker** and managed using **Docker Compose**. The system is currently built in **Python** using **Flask** for the core services, but is designed to be extendable with other technologies like **Java** or **Go**.

## Services

The project is divided into multiple services, each responsible for a different part of the payment processing lifecycle:

1. **API Gateway**: Routes incoming requests to appropriate services such as authentication, payment processing, etc.
2. **Authentication Service**: Manages user and merchant authentication using token-based (JWT) mechanisms.
3. **Payment Processing Service**: Handles payment routing, interacting with external payment gateways like Stripe or PayPal.
4. **Transaction State Service**: Tracks the lifecycle of transactions using Redis and Kafka for event-driven state management.
5. **Notification Service**: Sends SMS and email notifications to users and merchants based on transaction events.
6. **Fraud Detection Service**: Monitors transactions for potential fraud and risk, applying rule-based and machine learning models.
7. **Settlement Service**: Manages the reconciliation of payments between merchants and payment gateways.
8. **User Management Service**: Provides a platform for managing users' payment preferences, profile updates, and more.
9. **Reporting and Analytics Service**: Offers detailed insights into transaction data, fraud detection, and system performance.
10. **Monitoring Service**: Tracks system health, performance metrics, and logs for auditing purposes.
11. **Dispute Service**: Enables customers and merchants to manage payment disputes and chargebacks.

## Architecture

The system follows a **microservices** architecture, which provides the following advantages:
- **Scalability**: Each service can scale independently based on the workload.
- **Decoupled Teams**: Independent teams can work on different services, enabling parallel development.
- **Flexibility**: The architecture allows easy migration of services to other languages or frameworks like Java.

All services are connected using **Docker Compose** and communicate over HTTP and Kafka for event-driven communication.

### Key Technologies:
- **Python** with **Flask** for the backend services.
- **Docker** and **Docker Compose** for containerization and orchestration.
- **Redis** for caching.
- **Kafka** for asynchronous messaging and event handling.
- **PostgreSQL** for database storage.
- **Twilio** and **SendGrid** for notifications.

## Getting Started

### Prerequisites

Before you start, ensure you have the following installed:
- **Docker** and **Docker Compose**
- **Python 3.x** and **pip**
- **GitHub CLI (`gh`)** for repository management
- **SSH access** configured for GitHub

### Setting Up the Project

1. **Clone the repository**:
   ```bash
   git clone git@github.com:dullbrowny/payment-system.git
   cd payment-system
