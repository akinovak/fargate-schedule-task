variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "base_namespace" {
  type        = string
  description = "Base namespace"
}

variable "base_tags" {
  type        = any
  description = "Tags to merge with local defaults"
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "task_name" {
  type        = string
  description = "Scheduled task name"
}

variable "cluster_name" {
  type        = string
  description = "Scheduled task name"
}

variable "task_definition" {
  type        = string
  description = "json or rendered file"
}

variable "ecs_task_execution_role_arn" {
  type        = string
  description = "ARN of ECS task execution role"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of VPC private subnets"
}

variable "memory" {
  type        = number
  description = "Memory allocation for task"
}

variable "cpu" {
  type        = number
  description = "cpu allocation for task"
}

variable "event_rule_schedule_expression" {
  type        = string
  description = "frequency of task execution"
}

variable "logs_volume_source" {
  type        = string
}