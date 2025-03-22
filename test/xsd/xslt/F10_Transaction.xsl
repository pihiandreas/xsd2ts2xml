<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:uuid="java:java.util.UUID"
xmlns:enrich="java:com.cgi.cms.mhb.utl.mtc.enrich.XMLEnricher"
exclude-result-prefixes="enrich uuid"
xmlns:urn="urn:cms:b2b:v01" 
xmlns:urn1="urn:fi:Datahub:mif:metering:F10_RequestSettlementDataInfo:v1" 
xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" 
xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" 
xmlns:urn4="urn:fi:Datahub:mif:metering:F10_RequestSettlementDataInfo:elements:v1">

	<xsl:param name="TenantCode" select="'FGR'" />
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" />

	<xsl:template name="RequestSettlementDataInfoTransactionTemplate" match="urn1:RequestSettlementDataInfo">
		<_name>Transaction</_name>
		<_type>TRANSACTION</_type>
		<xsl:variable name="ProcessRole" select="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcessRole"/>
		<xsl:if test="urn1:Header/urn2:Identification">
			<ExternalTransactionID>
				<xsl:value-of select="urn1:Header/urn2:Identification"/>
			</ExternalTransactionID>
		</xsl:if>
		<AuthorisationField1>
			<xsl:value-of select="$ProcessRole"/>
		</AuthorisationField1>
		<_entities>
			<_entities_element>
				<_name>TransactionHeader</_name>
				<_type>TRANSACTION_HEADER</_type>
				<!--For MHB only -->
				<xsl:if test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess">
					<InternalTransactionType>
						<xsl:choose>
							<xsl:when test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess='DH-521' and $ProcessRole='DDQ'">STS.RTR</xsl:when>
							<xsl:when test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess='DH-522' and $ProcessRole='DDM'">STS.RTR</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess" />
							</xsl:otherwise>
						</xsl:choose>
					</InternalTransactionType>
				</xsl:if>
				<InternalTransactionID>
					<xsl:value-of select="uuid:randomUUID()" />
				</InternalTransactionID>
				<PayloadType>RSTS</PayloadType>
			</_entities_element>

			<xsl:variable name="JuridicalSender" select="urn1:Header/urn2:JuridicalSenderEnergyParty/urn2:Identification"/>
			
			<xsl:for-each select="urn1:Transaction">
				<_entities_element>
					<xsl:call-template name="RequestMeasuredDataInfoPayloadTemplate">
						<xsl:with-param name="dsoID" select="$JuridicalSender"/>
					</xsl:call-template>
				</_entities_element>		
			</xsl:for-each>
		</_entities>
	</xsl:template>		

	<xsl:template name="RequestMeasuredDataInfoPayloadTemplate" match="urn1:Transaction">	
		<xsl:param name="dsoID"/> 
		<_name>Payload</_name>
		<_type>PAYLOAD</_type>
		<_entities>
			<_entities_element>
				<_name>TransactionPayload</_name>
				<_type>RSTS</_type>
				<xsl:element name="PeriodStartTS">
					<xsl:value-of select="urn4:RequestPeriod/urn4:Start"/>
				</xsl:element>
				<xsl:element name="PeriodEndTS">
					<xsl:value-of select="urn4:RequestPeriod/urn4:End"/>
				</xsl:element>
				<xsl:choose>
					<xsl:when test="urn4:BusinessType='BI01'">
						<TimeSeriesType>IB_BS_CON_PD</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI02'">
						<TimeSeriesType>IB_BS_CON_NPD</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI03'">
						<TimeSeriesType>IB_BS_OCON_PD</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI04'">
						<TimeSeriesType>IB_BS_OCON_NPD</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI05'">
						<TimeSeriesType>IB_BS_SSP_PDN</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI06'">
						<TimeSeriesType>IB_PU</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI07'">
						<TimeSeriesType>IB_MGA_LOSS</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI08'">
						<TimeSeriesType>IB_MGA_NLOSS</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI09'">
						<TimeSeriesType>IB_MGA_IB_ISR</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI10'">
						<TimeSeriesType>IB_MGA_CON_PD</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI11'">
						<TimeSeriesType>IB_MGA_CON_NPD</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI12'">
						<TimeSeriesType>IB_MGA_OCON_PD</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI13'">
						<TimeSeriesType>IB_MGA_OCON_NPD</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI14'">
						<TimeSeriesType>IB_MGA_SSP_PDN</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI15'">
						<TimeSeriesType>IB_MGA_SSP_TOT</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI16'">
						<TimeSeriesType>IB_MGA_PU_PDN</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI17'">
						<TimeSeriesType>IB_MGA_PU_TOT</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI18'">
						<TimeSeriesType>IB_MGA_MGX</TimeSeriesType>
					</xsl:when>
					<xsl:when test="urn4:BusinessType='BI19'">
						<TimeSeriesType>IB_MGA_MGX_TOT</TimeSeriesType>
					</xsl:when>					
					<xsl:when test="urn4:BusinessType='BI20'">
						<TimeSeriesType>IB_MGA_MGX_ISR</TimeSeriesType>
					</xsl:when>	
				</xsl:choose>
				<xsl:choose>				
					<xsl:when test="urn4:DataCorrectedOutsideBalanceWindow='1'">
						<smtType>IMBALANCE_OBW</smtType>
					</xsl:when>
					<xsl:otherwise>
						<smtType>IMBALANCE</smtType>
					</xsl:otherwise>
				</xsl:choose>
				<_entities>
					<_entities_element>
						<_name>MeteringGridArea</_name>
						<_type>MGA</_type>
						<xsl:element name="MeteringGridArea">
							<xsl:value-of select="urn4:MeteringArea"/>
						</xsl:element>
					</_entities_element>
					<_entities_element>				
						<_name>dsoID</_name>
						<_type>DSO</_type>
						<xsl:element name="dsoID">
							<xsl:value-of select="$dsoID"/>
						</xsl:element>	
					</_entities_element>
					<_entities_element>
						<_name>Supplier</_name>
						<_type>SUP</_type>
						<xsl:variable name="SupID" select="enrich:getOrganisationID(urn4:Supplier, $TenantCode, 'DDQ', 'DDQ')"/>
						<xsl:element name="Supplier">
							<xsl:value-of select="$SupID"/>
						</xsl:element>
					</_entities_element>
				</_entities>
			</_entities_element>
		</_entities>
	</xsl:template>
</xsl:stylesheet>
