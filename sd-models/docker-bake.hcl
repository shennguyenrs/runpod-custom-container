variable "RELEASE" {
    default = "1.0.0"
}

target "default" {
  dockerfile = "Dockerfile"
  tags = ["shennguyenrs/sd-models:${RELEASE}"]
}