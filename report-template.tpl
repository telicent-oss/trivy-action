{{- if . }}
{{- range . }}
<h3>Target <code>{{ escapeXML .Target }}</code></h3>
{{- if (eq (len .Vulnerabilities) 0) }}
<h4>No Vulnerabilities found</h4>
{{- else }}
<h4>Vulnerabilities ({{ len .Vulnerabilities }})</h4>
<table>
    <tr>
        <th>Package</th>
        <th>ID</th>
        <th>Severity</th>
        <th>Installed Version</th>
        <th>Fixed Version</th>
    </tr>
    {{- range .Vulnerabilities }}
    <tr>
        <td><code>{{ escapeXML .PkgName }}</code></td>
        <td>{{ escapeXML .VulnerabilityID }}</td>
        <td>{{ escapeXML .Severity }}</td>
        <td>{{ escapeXML .InstalledVersion }}</td>
        <td>{{ escapeXML .FixedVersion }}</td>
    </tr>
    {{- end }}
</table>
{{- end }}
{{- end }}
{{- else }}
<h3>Trivy Returned Empty Report</h3>
{{- end }}