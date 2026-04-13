# cloudwatch log group
resource "aws_cloudwatch_log_group" "esc_task_log_group" {
  name              = "${var.prefix}_esc_task_log_group"
  retention_in_days = var.retention_in_days

  tags = {
    Name = "${var.prefix}_esc_task_log_group"
  }
}