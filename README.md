# XsdChecker

Supports XSD 1.0.

```yaml
- name: Validate using XSDs
  uses: klakegg/xsdchecker@master
  with:
    script: |
       xc --xsd-1.0 **/*.xsd
       xc --xslt-2.0 **/*.xslt
```
