resource "aws_ecs_cluster" "task_cluster" {
  name = var.cluster_name
  tags = local.default_tags
}

module "ecs-fargate-scheduled-task" {
  source = "umotif-public/ecs-fargate-scheduled-task/aws"
  version = "~> 1.0.0"

  name_prefix = "${local.namespace}-${var.task_name}-task"

  ecs_cluster_arn = aws_ecs_cluster.task_cluster.arn

  task_role_arn      = module.ecs_task_role.this_iam_role_arn
  execution_role_arn = var.ecs_task_execution_role_arn

  event_target_task_definition_arn = aws_ecs_task_definition.ecs_task_definition.arn
  event_rule_schedule_expression   = var.event_rule_schedule_expression
  event_target_subnets             = var.private_subnet_ids
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                = local.namespace
  container_definitions   = var.task_definition

  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn      = module.ecs_task_role.this_iam_role_arn
  network_mode       = "awsvpc"

  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  volume {
    name = var.logs_volume_source
  }

  tags = local.default_tags
}