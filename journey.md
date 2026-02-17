# DevOps Assessment –Journey

## Starting Point

The original project included:

- A FastAPI backend
- A Celery worker
- Redis as a message broker
- A simple frontend

The application worked locally, but everything was tied to `localhost` and there was no containerization or deployment structure. From a DevOps perspective, it needed proper service separation, configuration cleanup, and infrastructure planning.

---

## Step 1 – Containerization

I began by restructuring the backend into its own folder and creating a Dockerfile.  

Then I used Docker Compose to orchestrate three services:

- Backend
- Worker
- Redis

This setup reflects how services would typically run in production — independently but connected through a network.

### Issue I Encountered

Initially, Redis was configured using `localhost`.  

Inside Docker, `localhost` refers to the container itself — not other containers. As a result, the worker could not connect to Redis.

### How I Fixed It

I replaced the hardcoded Redis configuration with an environment variable (`REDIS_URL`).  

In Docker Compose, I configured Redis to be reachable using the service name `redis`. This allowed proper inter-container communication using Docker’s internal networking.

Once this was fixed, the backend and worker communicated correctly.

---

## Step 2 – Validating the Async Flow

After fixing networking, I validated the full flow:

1. POST `/notify/` enqueues a task.
2. The worker consumes the task asynchronously.
3. GET `/task_status/{task_id}` returns the correct status and result.

This confirmed that background processing works correctly in a multi-container setup.

---

## Step 3 – CI/CD Pipeline

Next, I implemented a GitHub Actions workflow.

The pipeline triggers on every push to the `main` branch and builds the Docker images for backend and worker services.

The goal here was to ensure that:

- The application builds successfully in a clean environment.
- Container builds are reproducible.
- No manual validation is required for basic build integrity.

This simulates a real CI stage before deployment.

---

## Step 4 – Infrastructure as Code (Design Approach)

Under the `infra` directory, I created Terraform configuration files to demonstrate how this application would be deployed in AWS.

The design includes:

- VPC
- Subnet
- Security Group
- ECS Cluster
- ECS Task Definition
- ElastiC
