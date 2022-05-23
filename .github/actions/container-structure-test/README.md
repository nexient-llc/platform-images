## Required inputs

- `image`: Image:Tag to Test (e.g. `nexientdevops/container-template:dev`)
- `config`: Path to structure test file (e.g. `test.yaml`)

## Example

```yaml
name: "Run Container Structure Tests"
on: push

jobs:
  dockerfile-test:
    runs-on: ubuntu-latest
    steps:
    - name: checkout source
      uses: actions/checkout@master
    
    - name: Run Container Tests
      uses: ./.github/actions/container-structure-test
      with:
        image: nexientdevops/container-template:test
        config: test.yaml
```