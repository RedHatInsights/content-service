# Insights Content Service Documentation

Insights Content Service is a service that provides metadata information about rules that are being consumed by Openshift Cluster Manager. That metadata information contains rule title, description, remediations, tags and also groups, that will be consumed primarily by [Insights Results Aggregator](https://github.com/RedHatInsights/insights-results-aggregator).

## Documentation Index

### Getting Started

- [Architecture](architecture.md) - Overview of the service architecture and main components
- [Sequence Diagram](sequence_diagram.md) - Visual representation of service interaction flow
- [Role in External Data Pipeline](role.md) - How this service fits into the broader insights ecosystem

### API Documentation

- [REST API](rest_api.md) - Information about the REST API endpoints and OpenAPI schema
- [Prometheus API](prometheus.md) - Metrics exposed for monitoring and observability

### Configuration & Operations

- [Configuration](configuration.md) - How to configure the service (server, groups, content, metrics, logging)
- [Content Checker](content_checker.md) - Utility for validating rule content and group configuration

### Development

- [Testing](testing.md) - How to run unit tests and generate coverage reports
- [CI](ci.md) - Continuous integration checks and tools used
- [Contributing](contributing.md) - Contribution guidelines

### Additional Resources

- [References](references.md) - Links to related documentation and schemas

### Diagrams & Assets

The `architecture/` directory contains various diagrams:
- Architecture diagrams (PNG, SVG, GIF formats)
- Sequence diagrams (UML source and rendered versions)
- Class diagrams

## Quick Links

- [Main Repository](https://github.com/RedHatInsights/content-service)
- [Insights Data Schemas](https://redhatinsights.github.io/insights-data-schemas/)
- [Insights Results Smart Proxy](https://redhatinsights.github.io/insights-results-smart-proxy/)
