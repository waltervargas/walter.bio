---
layout: post
title:  "How to mirror git repositories"
date:   2017-06-28 22:14:15 -0400
categories: 
comments: true
crosspost_to_medium: true
---

There are projects where having a working git repository separated from the
customer repository is a requirement. For this cases, I am using the following
script to parse a YAML file `repos.yml` and keep the repositories in sync.


``` shell
#!/usr/bin/env bash

function json {
    local file=$1
    local json=$(cat $file | python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)')
    echo ${json}
}

JSON=$(json "repos.yml")
repos=$(echo ${JSON} | jq -r 'keys[]')

for repo in $repos; do
    if [[ ! -d $repo ]]; then
        origin=$(echo ${JSON} | jq -r ".\"${repo}\" | .origin")
        upstream=$(echo ${JSON} | jq -r ".\"${repo}\" | .upstream")
        echo "[$repo]:"
        echo "  - git clone --mirror"
        git clone --mirror $upstream
        cd $repo
        echo "  - git set-url --push $origin"
        git remote set-url --push origin $origin
        cd ../
    fi

    if [[ -d $repo ]]; then
        mirror=$(echo ${JSON} | jq -r ".\"${repo}\" | .mirror")
        if [[ $mirror = true ]]; then
            echo "[$repo]: "
            cd $repo
            echo " - git fetch upstream"
            git fetch -p origin
            echo " - git push mirror"
            git push --mirror
            cd ../
            echo -e "\n"
        fi
    fi
done
```

```yaml
aws-modules.git:
  upstream: git@github.com:customer/aws-modules.git
  origin: git@github.com:our-company/customer-aws-modules.git
  mirror: true

aws-service.git:
  upstream: git@github.com:customer/aws-service.git
  origin: git@github.com:our-company/customer-aws-service.git
  mirror: true

aws-app.git:
  upstream: git@github.com:customer/aws-app.git
  origin: git@github.com:our-company/customer-aws-app.git
  mirror: true
```

## Questions

If you have questions, you can ask me on this post as a Disqus comment.
