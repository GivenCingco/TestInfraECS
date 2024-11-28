resource "aws_cloudwatch_log_group" "ecs_task_logs" {
  name              = "/ecs/hpo-api-task"
  retention_in_days = 7
}
