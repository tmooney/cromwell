cwlVersion: v1.0
$graph:
  id: hello
  class: CommandLineTool
  requirements:
    - class: DockerRequirement
      dockerPull: us.gcr.io/google-containers/ubuntu-slim:0.14
  baseCommand: echo
  inputs:
    message:
      type: string
      inputBinding:
        position: 1
  stdout: hello-stdout.txt
  outputs:
    - id: salutation
      type: string
      outputBinding:
        glob: hello-stdout.txt
        loadContents: true
        outputEval: $(self[0].contents.trim())
