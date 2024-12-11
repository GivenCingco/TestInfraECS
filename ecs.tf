# ECS Cluster
resource "aws_ecs_cluster" "api_app_cluster" {
  name = "hpo-staging-api-cluster"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "api_app_task" {
  family                   = "hpo-api-task"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "hpo-api-task",
      "image": "${var.ecr_repo_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80,
          "protocol": "tcp"
        }
      ],
      "memory": 512,
      "cpu": 256,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/hpo-api-task",
          "awslogs-region": "eu-west-2",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

# ECS Service
resource "aws_ecs_service" "demo_app_service" {
  name            = "hpo-api-service"
  cluster         = aws_ecs_cluster.api_app_cluster.id
  task_definition = aws_ecs_task_definition.api_app_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  # Reference existing ALB target group
  load_balancer {
    target_group_arn = data.aws_lb_target_group.existing_target_group.arn
    container_name   = "hpo-api-task"
    container_port   = 80
  }

  network_configuration {
    subnets          = module.vpc.public_subnets
    assign_public_ip = true
    security_groups  = [module.ALB-security-group.security_group_id]
  }

  # Wait for ALB listener to be created before ECS Service
  depends_on = [aws_lb_listener.alb-listener]
}

# IAM Role for Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "hpo-api-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}