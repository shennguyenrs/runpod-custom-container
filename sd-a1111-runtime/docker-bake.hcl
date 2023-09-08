variable "RELEASE" {
  default = "1.1.3"
}

target "default" {
  dockerfile = "Dockerfile"
  tags = ["shennguyenrs/sd-webui-runtime:${RELEASE}"]
  contexts = {
    proxy = "../proxy"
    scripts = "../scripts"
  }
}
