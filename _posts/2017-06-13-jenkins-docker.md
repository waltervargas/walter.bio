---
layout: post
title:  "Local Jenkins inside Docker for Development"
date:   2017-06-11 22:58:47 -0400
categories: jenkins docker development devops ci/cd
comments: true
---

Is helpful to run your own Jenkins instance to test your jobs and
pipelines. Docker and docker-compose make this task doable in a few of steps.

My recommendation is to prepare `Dockerfile` that inherits from the official
Jenkins docker image, and customize the packages and jenkins plugins that you
want to use.

## Clone and Run

1. Clone the repository
   ```sh
git clone git@github.com:waltervargas/jenkins.git
```
2. Run
   ```sh
cd jenkins
docker-compose up
```
3. Go to http://localhost:8080/

## References

Check out the [Official Jenkins Docker Image][official-jenkins-docker-image]
documentation for more info on how to get the most out of Jenkins in Docker.

## Bugs

File all bugs/feature requests
at [waltervargas/jenkins GitHub repo][waltervargas-jenkins]. 

## Questions

If you have questions, you can ask me on this post as a disqus comment.

[official-jenkins-docker-image]: https://github.com/jenkinsci/docker#official-jenkins-docker-image
[waltervargas-jenkins]: https://github.com/waltervargas/jenkins/issues
