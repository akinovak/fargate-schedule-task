provider "aws" {
  region = var.aws_region
}

data "aws_ecr_repository" "task_repository" {
  name = "example-task"
}

resource "aws_cloudwatch_log_group" "main" {
  name = "/ecs/example-task"
}

data "template_file" "task_definition" {
  template = file("${path.module}/task_definition.json.tpl")

  vars = {
    name                 = var.namespace
    image                = "${data.aws_ecr_repository.task_repository.repository_url}:${var.env}"
    log_group            = aws_cloudwatch_log_group.main.name
    region               = var.aws_region
    logs_volume_source   = "example-task-logs"
  }
}


module "scheduled-task" {
  source = "../scheduled-task"

  aws_region                          = var.aws_region
  base_namespace                      = var.namespace
  base_tags                           = var.tags
  env                                 = var.env
  task_name                           = "example-task"
  cluster_name                        = "${var.namespace}-example-task"
  task_definition                     = data.template_file.task_definition.rendered
  ecs_task_execution_role_arn         = var.ecs_task_execution_role_arn
  private_subnet_ids                  = var.private_subnet_ids
  logs_volume_source                  = "example-task-logs"

  memory                              = 2048
  cpu                                 = 256

  event_rule_schedule_expression      = "rate(1 minute)"
}