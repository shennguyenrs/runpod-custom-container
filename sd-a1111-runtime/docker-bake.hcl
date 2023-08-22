variable "RELEASE" {
    default = "1.0.0"
}

target "default" {
  dockerfile = "Dockerfile"
  tags = ["shennguyenrs/sd-webui-runtime:${RELEASE}"]
  contexts = {
    proxy = "../proxy"
    scripts = "../scripts"
  }
}