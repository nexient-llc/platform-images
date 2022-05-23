---
name: Bug report
about: Create a report to help us improve
---

### Host Information

- OS and Version:
- Docker Version:
- Tag of the container being used:
- Output of `docker info`:
  ```
  Client:
  Context:    default
  Debug Mode: false
  Plugins:
    buildx: Docker Buildx (Docker Inc., v0.8.1-docker)
  ... truncated output ...
  ```

### Behaviour

#### Steps to reproduce this issue

1.
2.
3.

#### Expected behaviour

> Tell us what should happen

#### Actual behaviour

> Tell us what happens instead

### Configuration

> Enter command and configuration used to launch container (masking any sensitive information)


```
## EXAMPLE
docker run -d -p 80:8080 --name test \
  --env "TEMP_VAR=test" \
  --volume "/path/to/local/volume:/path/to/container/volume" \
  nexientdevops/container-template:latest
```

### Logs
> Place any relevant logs or console output