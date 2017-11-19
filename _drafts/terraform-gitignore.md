---
layout: post
title:  "A good .gitignore policy for a terraform repository"
date:   2017-06-28 22:39:24 -0400
categories: iac terraform
comments: true
crosspost_to_medium: true
---

```git
.terraform
*.tfstate
*.tfstate.backup
```

```python
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

class MyWindow(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Hello World")

        self.button = Gtk.Button(label="Click Here")
        self.button.connect("clicked", self.on_button_clicked)
        self.add(self.button)

        self.label = Gtk.Label()
        self.label.set_label("Hello World")
        self.label.set_angle(25)
        self.label.set_halign(Gtk.Align.END)

        self.add(self.label)

    def on_button_clicked(self, widget):
        print("Hello World")

def main():
    win = MyWindow()
    win.connect("delete-event", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == '__main__':
    main()

```

```hcl
terraform {
  backend "s3" {
    #bucket  = "${var.bucket}"
    bucket  = "walter-devops-us-east-1"
    key     = "terraform/dev/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

resource "aws_s3_bucket" "w" {
  bucket = "my_tf_test_bucket_w"
  acl    = "private"

  tags = "${merge(var.tags, map(var.transitvpc_spoke_tag_key, var.transitvpc_spoke_tag_value))}"
}
```

## References

## Questions

If you have questions, you can ask me on this post as a Disqus comment.
