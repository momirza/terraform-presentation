Docker allows you to build and run code in <span class="gold">containers</span>

+++

A container is a lightweight VM

+++?image=assets/images/vmvcontainers.png&size=contain



+++

@fa[bolt fa-4x]

+++

`docker run -it ubuntu`

+++

You can build your own images by writing a <span class="gray">`Dockerfile`</span>

+++?image=assets/images/holy_cow.png&size=auto 22%

+++?code=code/cow/Dockerfile&lang=dockerfile

@[1](Download Ubuntu 16.04 from Docker Registry)

+++?image=assets/images/docker-store.png&size=contain

+++?code=code/cow/Dockerfile&lang=dockerfile

@[3](Update package manager and install <span class="gray">`cowsay`</span>)
@[5](Change the default entrypoint of the container to <span class="gray">`cowsay`</span>)

+++

@fa[wrench 4x]

`docker build -t moo .`


+++

That's cool but what about microservices?

<theed face here>