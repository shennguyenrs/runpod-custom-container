variable "RELEASE" {
  default = "2.1.0"
}

target "default" {
  dockerfile = "Dockerfile"
  tags = ["shennguyenrs/sd-webui-runtime:${RELEASE}"]
  contexts = {
    proxy = "../proxy"
    scripts = "../scripts"
  }
}
