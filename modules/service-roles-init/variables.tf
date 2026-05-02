variable "service_roles" {
  type = object({
    TCR_QCSRole = optional(bool, true)
    TKE_QCSRole = optional(bool, true)
    IPAMDofTKE_QCSRole = optional(bool, true)
    AS_QCSRole = optional(bool, true)
    CloudAudit_QCSRole = optional(bool, true)
    TSE_QCSRole = optional(bool, true)
    SSM_QCSRole = optional(bool, true)
    SSA_QcsRole = optional(bool, true)
    CFW_QcsRole = optional(bool, true)
    TCSS_QCSRole = optional(bool, true)
    CLB_QCSRole = optional(bool, true)
    Datahub_QcsRole = optional(bool, true)
  })
  default = {}
}

variable "ignored_policies" {
  type = list(string)
  default = []
}

variable "linked_service_roles" {
  type = object({
    WAF = optional(bool, true)
    Advisor_BusinessContinuity = optional(bool, true)
    CM_TMP = optional(bool, true)
    SSL_WAF = optional(bool, true)
    TKE_Prometheus = optional(bool, true)
    TDMQ_VPCdomainbinding = optional(bool, true)
    Beian_Resource = optional(bool, true)
    CLB_Certificate = optional(bool, true)
    TIC_IaC = optional(bool, false)
    VPC_FlowLog = optional(bool, true)
    TEO_Certlist = optional(bool, true)
    TEO_RealTimeLogCLS = optional(bool, true)
    SSL_CertificateDependence = optional(bool, true)
    TAT_COS = optional(bool, true)
    PrivateDNS_PL = optional(bool, true)
  })
  default = {}
}

variable "tags" {
  type = map(string)
  default = {}
}