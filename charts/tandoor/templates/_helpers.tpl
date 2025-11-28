{{/*
Expand the name of the chart.
*/}}
{{- define "tandoor.name" -}}
{{- .Values.nameOverride | default .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a fully qualified app name.
Uses fullnameOverride if set, otherwise uses nameOverride or Chart.Name.
Combines with Release.Name unless Release.Name already contains the name.
*/}}
{{- define "tandoor.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := .Values.nameOverride | default .Chart.Name -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tandoor.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Namespace to use
*/}}
{{- define "tandoor.namespace" -}}
{{- .Values.namespaceOverride | default .Release.Namespace -}}
{{- end -}}

{{/*
Common labels - includes chart, selector labels, version, and managed-by
These should be applied to all resources' metadata.labels
*/}}
{{- define "tandoor.labels" -}}
helm.sh/chart: {{ include "tandoor.chart" . }}
{{ include "tandoor.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{/*
Selector labels - these are the minimal labels used for pod selectors
Only includes name and instance to keep selectors stable
*/}}
{{- define "tandoor.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tandoor.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Service account name
*/}}
{{- define "tandoor.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- .Values.serviceAccount.name | default (include "tandoor.fullname" .) -}}
{{- else -}}
{{- .Values.serviceAccount.name | default "default" -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the cluster role to use
*/}}
{{- define "tandoor.clusterRoleName" -}}
{{- .Values.rbac.clusterRoleName | default (include "tandoor.fullname" .) -}}
{{- end -}}
