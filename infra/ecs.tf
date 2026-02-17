resource "aws_ecs_cluster" "main" {
  name = "healthpay-cluster"
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "healthpay-backend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "backend"
      image     = "your-ecr-repo/backend:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ]
    }
  ])
}
