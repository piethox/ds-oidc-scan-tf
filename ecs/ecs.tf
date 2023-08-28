resource "aws_ecs_cluster" "ds2-test-cluster" {
  name = "ds2-test-app-cluster"
}

resource "aws_ecs_task_definition" "ds2-test-td" {
  family = "ds2-test-app-td"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = "512"
  memory = "1024"
  execution_role_arn = "arn:aws:iam::255945442255:role/ecsTaskExecutionRole"
  container_definitions = file("ecs-td-container-definition.json")
}

resource "aws_security_group" "ds2-ecs-sg" {
  vpc_id = var.vpc_id
  name = "ds2-ecs-sg"
  
  ingress {
    from_port = 3030
    to_port = 3030
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_ecs_service" "ds2-test-service" {
  name = "ds2-test-app-service"
  cluster = aws_ecs_cluster.ds2-test-cluster.id
  task_definition = aws_ecs_task_definition.ds2-test-td.arn
  launch_type = "FARGATE"
  depends_on = [ aws_security_group.ds2-ecs-sg ]
  desired_count = 1
  
  network_configuration {
    subnets = var.subnets
    security_groups = [aws_security_group.ds2-ecs-sg.id]
    assign_public_ip = true
  }
}