variable "RELEASE" {
  default = "2.0.0"
}

target "default" {
  dockerfile = "Dockerfile"
  tags = ["shennguyenrs/sd-webui-runtime:${RELEASE}"]
  contexts = {
    proxy = "../proxy"
    scripts = "../scripts"
  }
}
