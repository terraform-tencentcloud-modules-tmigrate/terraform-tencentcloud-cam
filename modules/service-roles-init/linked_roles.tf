
locals {
  linked_service_role_names = {
    WAF = {
      access = ["access.waf.cloud.tencent.com"],
      # csip_globalscene = ["csip.cloud.tencent.com"]
    }
    Advisor_BusinessContinuity = {
      role1 = ["businesscontinuity.advisor.cloud.tencent.com"]
    }
    CM_TMP = {
      role1 = ["cvm.qcloud.com", "tmp.monitor.cloud.tencent.com"]
    }
    SSL_WAF = {
      role1 = ["certificatewaf.ssl.cloud.tencent.com"]
    }
    TKE_Prometheus = {
      role1 = ["cvm.qcloud.com", "prometheusservice.tke.cloud.tencent.com"]
    }
    TDMQ_VPCdomainbinding = {
      role1 = ["tdmqrocketmqvpcdomainbinding.tdmq.cloud.tencent.com"]
    }
    Beian_Resource = {
      role1 = ["describebeianresource.beian.cloud.tencent.com"]
    }
    CLB_Certificate = {
      role1 = ["clb.cloud.tencent.com"]
    }
    TIC_IaC = {
      role1 = ["infrastructureascode.tic.cloud.tencent.com"]
    }
    VPC_FlowLog = {
      role1 = ["flowlogadvanceanalysis.vpc.cloud.tencent.com"]
    }
    TEO_Certlist = {
      role1 = ["certlist.teo.cloud.tencent.com"]
    }
    TEO_RealTimeLogCLS = {
      role1 = ["realtimelogcls.teo.cloud.tencent.com"]
    }
    SSL_CertificateDependence = {
      role1 = ["certificatedependence.ssl.cloud.tencent.com"]
    }
    TAT_COS = {
      role1 = ["uploadinvocation.tat.cloud.tencent.com"]
    }
    PrivateDNS_PL = {
      role1 = ["privatedns.cloud.tencent.com"]
    }
  }

  service_linked_roles = flatten([
    for product, product_roles in local.linked_service_role_names: [
      for role_key, roles in product_roles: {
        k = format("%s_%s", product, role_key)
        roles = roles
      } if var.linked_service_roles[product]
    ]
  ])
  service_linked_role_map = { for role in local.service_linked_roles: role.k => role.roles }
}

resource "tencentcloud_cam_service_linked_role" "service_linked_role" {
  for_each = local.service_linked_role_map
  qcs_service_name = each.value
  description      = null
  tags = var.tags

  lifecycle {
    ignore_changes = [
      description
    ]
  }
}