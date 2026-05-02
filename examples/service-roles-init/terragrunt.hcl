
terraform {
  source = "../"
}
inputs = {
  service_roles = {
    TCR_QCSRole = false
    TKE_QCSRole = false
    IPAMDofTKE_QCSRole = false
    AS_QCSRole = false
    CloudAudit_QCSRole = false
    TSE_QCSRole = false
    SSM_QCSRole = false
    SSA_QcsRole = false
    CFW_QcsRole = false
    TCSS_QCSRole = false
    CLB_QCSRole = false
    Datahub_QcsRole = false
  }
}