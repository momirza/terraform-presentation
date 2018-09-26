
## Development with Containers

![docker-logo](assets/images/docker-whale-home-logo.png)

+++

Docker allows you to build and run code in <span class="gold">containers</span>

+++

A container is a lightweight VM

+++?image=assets/images/vmvcontainers.png&size=contain


+++

@fa[bolt fa-4x]

+++

Build your own images by writing a <span class="gray">`Dockerfile`</span>


+++?code=code/cow/Dockerfile&lang=dockerfile

```bash
$ docker build --tag cow .
```

+++

```bash
$ docker run cow "Moooo"
 -------
< Moooo >
 -------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

```
+++ 

https://github.com/momirza/docker-presentation