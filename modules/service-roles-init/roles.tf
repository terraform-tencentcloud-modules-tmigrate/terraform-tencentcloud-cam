locals {

  roles = {
    TCR_QCSRole = {
      name = "TCR_QCSRole"
      description = "TCR permissions (including but not limited to): COS (create bucket, read/write/delete/copy object, initiate multiple upload); VPC (query VPC and subnet)."
      service = "tcr.cloud.tencent.com"
      policies = [
        "QcloudAccessForTCRRole"
      ]
    }
    TKE_QCSRole = {
      name = "TKE_QCSRole"
      description = "The current role is the TKE service role, which will access your other service resources within the scope of the permissions of the associated policy."
      service = "ccs.qcloud.com"
      policies = [
        "QcloudAccessForTKERoleInOpsManagement",
        "QcloudAccessForTKERole",
        "QcloudAccessForTKERoleInOIDCConfig",
        "QcloudAccessForTKERoleInCreatingCFSStorageclass",
        "QcloudCVMFinanceAccess",
        "QcloudAccessForTKERoleInGroupsForUser",
      ]
    }
    IPAMDofTKE_QCSRole = {
      name        = "IPAMDofTKE_QCSRole"
      description = "TKE IPAMD permissions (including but not limited to): CVM (query CVM info); VPC (add/delete/query VPC ENI); Tag (create tags for ENIs and query ENI info via tags)."
      service     = "ccs.qcloud.com"
      policies    = [
        "QcloudAccessForIPAMDofTKERole"
      ]
    }
    AS_QCSRole = {
      name        = "AS_QCSRole"
      description = "The current role is the AS service role, which will access your other service resources within the scope of the permissions of the associated policy."
      service     = "as.cloud.tencent.com"
      policies    = [
        "QcloudAccessForASRole",
        "QcloudAccessForASRoleInAutomationTools"
      ]
    }
    CloudAudit_QCSRole = {
      name        = "CloudAudit_QCSRole"
      description = "Cloud Audit permissions (including but not limited to): CAM(QcloudCamReadOnlyAccess );CVM(QcloudCVMReadOnlyAccess);VPC(QcloudVPCReadOnlyAccess);MySQL(QcloudCDBInnerReadOnlyAccess);CLB(QcloudCLBReadOnlyAccess);AS(QcloudASReadOnlyAccess);COS(QcloudCOSReadOnlyAccess,put bucket);CMQ(add/query queue); KMS(add/query key)."
      service     = "cloudaudit.cloud.tencent.com"
      policies    = [
        "QcloudAccessForCARole"
      ]
    }
    TSE_QCSRole = {
      name        = "TSE_QCSRole"
      description = "The current role is the TSE service role, which will access your other service resources within the scope of the permissions of the associated policy."
      service     = "tse.qcloud.com"
      policies    = [
        "QcloudAccessForTSERole"
      ]
    }
    SSM_QCSRole = {
      name        = "SSM_QCSRole"
      description = "SSM permissions (including but not limited to): KMS(add/query KMS CMK, decrypt, encrypt, create data key)."
      service     = "ssm.qcloud.com"
      policies    = [
        "QcloudAccessForSSMRole"
      ]
    }
    SSA_QcsRole = {
      name        = "SSA_QcsRole"
      description = "SSA permissions(including but not limited to): CVM( query CVM instances,associate/disassociate/create/delete CVM security groups,create CVM security group policy); CLB (query CLB instance, health status and listening list); COS (query COS bucket list, replication config info, bucket version and bucket ACL/Policy,COS objects); WSS (query SSL certificate list);TencentDB (query MySQL/MariaDB/Redis instances, backup info and logs)."
      service     = "ssa.qcloud.com"
      policies    = [
        "QcloudAccessForSSARoleInLogDeliver",
        "QcloudAccessForSSARoleInSecurityOrchestration",
        "QcloudAccessForSSARoleInCSPM"
      ]
    }
    CFW_QcsRole = {
      name        = "CFW_QcsRole"
      description = "The current role is the CFW service role, which will access your other service resources within the scope of the permissions of the associated policy."
      service     = "cfw.qcloud.com"
      policies    = [
        "QcloudAccessForCFWRole"
      ]
    }
    TCSS_QCSRole = {
      name        = "TCSS_QCSRole"
      description = "The current role is the TCSS service role, which will access your other service resources within the scope of the permissions of the associated policy."
      service     = "tcss.cloud.tencent.com"
      policies    = [
        "QcloudAccessForTCSSRole",
        "QcloudAccessForTCSSRoleInKubernetesSec",
        "QcloudAccessForTCSSRoleInCkafka",
        "QcloudAccessForTCSSRoleInCls"
      ]
    }
    CLB_QCSRole = {
      name        = "CLB_QCSRole"
      description = "The current role is the CLB service role, which will access your other service resources within the scope of the permissions of the associated policy."
      service     = "clb.qcloud.com"
      policies    = [
        "QcloudAccessForCLBRole",
      ]
    }
    Datahub_QcsRole = {
      name        = "Datahub_QcsRole"
      description = ""
      service     = "ckafka.qcloud.com"
      policies    = [
        "QcloudCLSFullAccess",
      ]
    }
  }

  create_roles = {
    for k, role in local.roles: k => role if var.service_roles[k]
  }
  create_policy_atts = flatten([
    for k, role in local.roles: [
      for policy in role.policies: {
        k = format("%s_%s", k, policy)
        role = role.name
        policy = policy
      } if ! contains(var.ignored_policies, policy)
    ]// if var.service_roles[k]
  ])
  create_policy_att_map = { for p in local.create_policy_atts: p.k => p }
}

resource "tencentcloud_cam_role" "all" {
  for_each = local.create_roles
  name        = each.value.name
  session_duration = 7200
  document    = <<EOF
{
  "statement": [
    {
      "action":"name/sts:AssumeRole",
      "effect":"allow",
      "principal":{
        "service":"${each.value.service}"
      }
    }
  ],
  "version":"2.0"
}
EOF
  description = each.value.description
  tags = var.tags
  lifecycle {
    ignore_changes = [
      document, # this value should not be changed.
      description
    ]
  }
}

resource "tencentcloud_cam_role_policy_attachment_by_name" "all" {
  depends_on = [tencentcloud_cam_role.all]
  for_each = local.create_policy_att_map

  role_name   = each.value.role
  policy_name = each.value.policy
}
