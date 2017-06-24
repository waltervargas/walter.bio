---
layout: post
title:  "How to Compile Hashicorp Terraform using Docker"
date:   2017-06-21 13:40:02 -0400
categories: iac provisioning hashicorp terraform
comments: true
crosspost_to_medium: true
---

I am going to show you the way to compile Terraform by Hashicorp from source
code using docker. By using Docker, we save time since we do not need to install
golang and we don't have to setup the development environment. So save time and
hit the hay.

In some cases you will need to use terraform from `master` branch or test a
feature under development, Whether you are collaborating with the project, or
just requiring a fix or feature that is in a pull request.

> I am assuming that you have Docker engine installed and running.

Then, let's go to the point, there are only two commands: 

```sh
~/git
❯ git clone git@github.com:hashicorp/terraform.git
```

```sh
~/git/terraform master
❯ docker run --rm -v $(pwd):/go/src/github.com/hashicorp/terraform -w /go/src/github.com/hashicorp/terraform -e XC_OS=linux -e XC_ARCH=amd64 golang:latest bash -c "apt-get update && apt-get install -y zip && make bin"
```

When the compilation process ends, you will be able to use the Hashicorp
Terraform binary from the `bin` folder as follows:

```sh
❯ ~/git/terraform/bin/terraform -v
Terraform v0.10.0
```

## References

- [Hashicorp Terraform GitHub Repository][terraform-repo]
- [Golang Docker Image][golang-docker]
- [Use Terraform from Docker Images by @lgallard][tfdocker]

## Questions

If you have questions, you can ask me on this post as a Disqus comment.

[terraform-repo]: https://github.com/hashicorp/terraform
[golang-docker]: https://hub.docker.com/_/golang/
[tfdocker]: https://github.com/lgallard/tfdocker/blob/master/tfdocker
