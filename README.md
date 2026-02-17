#####HealthPay DevOps Assignment######

This is my submission for the DevOps assessment.

The goal was to take the given FastAPI + Celery + Redis application and make it production-ready from a DevOps perspective — focusing on containerization, CI/CD, and infrastructure design thinking.

What I Implemented

1. Containerization

I containerized:
FastAPI backend
Celery worker
Redis (as a service)

Using Docker and Docker Compose, I created a multi-service setup where:

The backend sends tasks to Redis
The worker consumes tasks from Redis
Task results are stored and can be queried

One important fix was removing hardcoded localhost references and replacing them with environment-based configuration so containers can communicate correctly using Docker DNS (redis service name).

How to Run Locally
Prerequisite
Docker Desktop installed and running
Run the application
docker compose up --build

Once running:

Swagger Docs → http://localhost:8000/docs
You can:
Call POST /notify/
Copy the returned task_id
Call GET /task_status/{task_id}
Observe async task execution

CI/CD Pipeline

I added a GitHub Actions workflow that:

Triggers on push to main
Builds Docker images for backend and worker
Ensures the project builds successfully
This validates container integrity automatically on every commit.

Infrastructure as Code (Design Level)

Under the infra/ folder, I created Terraform configuration files to demonstrate how this application would be deployed in AWS.
The design includes:
VPC
Subnet
Security Group
ECS Cluster (Fargate-ready)
ECS Task Definition
ElastiCache Redis
I did not apply Terraform (no AWS credentials used), but the structure shows how the system would be provisioned in a real cloud environment.

How I Would Deploy This in Production

If deployed to AWS:
Backend → ECS Fargate service
Worker → Separate ECS Fargate service
Redis → AWS ElastiCache (managed Redis)
Frontend → S3 + CloudFront
Logs → CloudWatch

Scaling:

Backend scaled on CPU
Worker scaled based on queue depth
The application is stateless and environment-driven, so it is cloud-ready.

Key Improvements Made:

Removed hardcoded Redis configuration
Introduced environment variables
Fixed Docker networking between services
Added CI pipeline
Structured infra as code blueprint
Ensured async flow works end-to-end
