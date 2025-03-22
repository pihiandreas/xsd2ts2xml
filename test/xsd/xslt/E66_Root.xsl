<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope"
	xmlns:urn="urn:cms:b2b:v01"
	xmlns:urn1="urn:fi:Datahub:mif:metering:E66_EnergyTimeSeries:v1"
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1"
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1"
	xmlns:urn4="urn:fi:Datahub:mif:metering:E66_EnergyTimeSeries:elements:v1"
	xmlns:uuid="java:java.util.UUID"
	xmlns:enrich="java:com.cgi.cms.mhb.utl.mtc.enrich.XMLEnricher"
	exclude-result-prefixes="enrich uuid">

	<xsl:import href="E66_Transaction.xsl" />

	<xsl:param name="TenantCode" select="'FGR'" />
	<xsl:param name="UserName" />
	<xsl:param name="UserIdentifier" />
	<xsl:param name="Channel" />
	<xsl:param name="ConfigVersion" />
	<xsl:param name="ProductVersion" />
	<xsl:param name="ReceivedTimestamp" />
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>

	<!-- Skip the SOAP Envelope Header as we don't process it -->
	<xsl:template name="SOAPHeaderTemplate" match="/*[local-name()='Envelope']/*[local-name()='Header']"/>

	<!-- Specific transaction template for each specific ebIX market message -->
	<xsl:template name="MessageTemplate"
		match="soapenv:Envelope/soapenv:Body/urn:SendMessageRequest/urn:MessageContainer/urn:Payload/urn1:EnergyTimeSeriesMessage">
		<entity>
			<_name>Message</_name>
			<_type>MESSAGE</_type>
			<xsl:if test="urn1:EnergyTimeSeries/urn1:Header/urn2:DocumentType">
				<ExternalMessageType>
					<xsl:value-of select="urn1:EnergyTimeSeries/urn1:Header/urn2:DocumentType"/>
				</ExternalMessageType>
			</xsl:if>
			<xsl:if test="urn1:EnergyTimeSeries/urn1:Header/urn2:Identification">
				<ExternalMessageID>
					<xsl:value-of select="urn1:EnergyTimeSeries/urn1:Header/urn2:Identification"/>
				</ExternalMessageID>
			</xsl:if>
			<xsl:if test="urn1:EnergyTimeSeries/urn1:Header/urn2:SenderRoutingInformation">
				<ExternalMessageReference>
					<xsl:value-of select="urn1:EnergyTimeSeries/urn1:Header/urn2:SenderRoutingInformation"/>
				</ExternalMessageReference>
			</xsl:if>
			<xsl:variable name="ProcessRole" select="urn1:EnergyTimeSeries/urn1:ProcessEnergyContext/urn3:EnergyBusinessProcessRole"/>
			<xsl:if test="$ProcessRole">
				<xsl:choose>
					<xsl:when test="$ProcessRole='MOP'">
						<ProcessRole>1</ProcessRole>
					</xsl:when>
					<xsl:when test="$ProcessRole='DDM'">
						<ProcessRole>2</ProcessRole>
					</xsl:when>
					<xsl:when test="$ProcessRole='DDM2'">
						<ProcessRole>3</ProcessRole>
					</xsl:when>
					<xsl:when test="$ProcessRole='DDK'">
						<ProcessRole>4</ProcessRole>
					</xsl:when>
					<xsl:when test="$ProcessRole='DDQ'">
						<ProcessRole>5</ProcessRole>
					</xsl:when>
					<xsl:when test="$ProcessRole='DDX'">
						<ProcessRole>6</ProcessRole>
					</xsl:when>
					<xsl:when test="$ProcessRole='DEA'">
						<ProcessRole>7</ProcessRole>
					</xsl:when>
					<xsl:when test="$ProcessRole='MDR'">
						<ProcessRole>8</ProcessRole>
					</xsl:when>
					<xsl:when test="$ProcessRole='SP'">
						<ProcessRole>9</ProcessRole>
					</xsl:when>
					<xsl:when test="$ProcessRole='ESC'">
						<ProcessRole>10</ProcessRole>
					</xsl:when>
					<xsl:otherwise>
						<ProcessRole>
							<xsl:value-of select="$ProcessRole" />
						</ProcessRole>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="urn1:EnergyTimeSeries/urn1:ProcessEnergyContext/urn3:EnergyIndustryClassification">
				<xsl:choose>
					<xsl:when test="urn1:EnergyTimeSeries/urn1:ProcessEnergyContext/urn3:EnergyIndustryClassification='23'">
						<Industry>1</Industry>
					</xsl:when>
					<xsl:otherwise>
						<Industry>
							<xsl:value-of select="urn1:EnergyTimeSeries/urn1:ProcessEnergyContext/urn3:EnergyIndustryClassification"/>
						</Industry>			
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="urn1:EnergyTimeSeries/urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess">
				<xsl:choose>
					<xsl:when test="urn1:EnergyTimeSeries/urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess='DH-211'">
						<BusinessProcess>7</BusinessProcess>
					</xsl:when>
					<xsl:otherwise>
						<BusinessProcess>
							<xsl:value-of select="urn1:EnergyTimeSeries/urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess"/>
						</BusinessProcess>			
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<_entities>
				<_entities_element>
					<_name>MessageHeader</_name>
					<_type>MESSAGE_HEADER</_type>
					<InternalMessageType>MSG.SND</InternalMessageType>
					<InternalMessageID>
						<xsl:value-of select="uuid:randomUUID()" />
					</InternalMessageID>	
					<ConfigVersion>
						<xsl:value-of select="$ConfigVersion" />
					</ConfigVersion>
					<ProductVersion>
						<xsl:value-of select="$ProductVersion" />
					</ProductVersion>					
					<ReceivedTimestamp>
						<xsl:value-of select="$ReceivedTimestamp" />
					</ReceivedTimestamp>					
					<xsl:variable name="PhysicalSenderID" select="enrich:getPhysicalSenderID(urn1:EnergyTimeSeries/urn1:Header/urn2:PhysicalSenderEnergyParty/urn2:Identification, $UserName,$TenantCode, $ProcessRole)"/>
					<PhysicalSenderID>
						<xsl:value-of select="$PhysicalSenderID" />
					</PhysicalSenderID>
					<xsl:variable name="JuridicalSender" select="urn1:EnergyTimeSeries/urn1:Header/urn2:JuridicalSenderEnergyParty/urn2:Identification"/>
					<JuridicalSenderID>
						<xsl:choose>
							<xsl:when test="$JuridicalSender">
								<xsl:value-of select="enrich:getJuridicalSenderID($JuridicalSender, $UserName, $TenantCode, $ProcessRole)" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$PhysicalSenderID" />
							</xsl:otherwise>
						</xsl:choose>
					</JuridicalSenderID>
					<xsl:variable name="PhysicalReceiverID" select="enrich:getPhysicalReceiverID($TenantCode)"/>
					<PhysicalReceiverID>
						<xsl:value-of select="$PhysicalReceiverID" />
					</PhysicalReceiverID>
					<xsl:variable name="JuridicalReceiverID" select="enrich:getJuridicalReceiverID($TenantCode)"/>
					<JuridicalReceiverID>
						<xsl:value-of select="$JuridicalReceiverID" />
					</JuridicalReceiverID>
					<TenantCode>
						<xsl:value-of select="$TenantCode" />
					</TenantCode>
					<xsl:variable name="OrganisationUserID" select="$UserName"/>								 
					<OrganisationUserID>
						<xsl:value-of select="enrich:getOrganisationUserID($UserName, $TenantCode)"/>
					</OrganisationUserID>
					<xsl:variable name="UserIdentityID" select="enrich:getUserIdentityID($UserIdentifier)"/>
					<UserIdentityID>
						<xsl:value-of select="$UserIdentityID" />
					</UserIdentityID>
					<Channel>
						<xsl:value-of select="$Channel" />
					</Channel>
					<xsl:choose>
						<xsl:when test="/*[local-name()='Envelope']/*[local-name()='Body']/*[local-name() = 'SendMessageRequest']">
							<xsl:variable name="IsSynchronousSend" select="enrich:isSynchronous('MSG.SND', 'CMS', $ProductVersion)"/>
							<xsl:if test="$IsSynchronousSend">
								<IsSynchronous>
									<xsl:value-of select="$IsSynchronousSend" />
								</IsSynchronous>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:variable name="IsSynchronousPrc" select="enrich:isSynchronous('MSG.PRC', 'CMS', $ProductVersion)"/>
							<xsl:if test="$IsSynchronousPrc">
								<IsSynchronous>
									<xsl:value-of select="$IsSynchronousPrc" />
								</IsSynchronous>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</_entities_element>
				<xsl:variable name="EnergyBusinessProcess" select="urn1:EnergyTimeSeries/urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess"/>
				<xsl:for-each select="urn1:EnergyTimeSeries/urn1:Transaction">
					<_entities_element>
						<xsl:call-template name="MeteringTransactionTemplate">
							<xsl:with-param name="EnergyBusinessProcess" select="$EnergyBusinessProcess"/>
							<xsl:with-param name="ProcessRole" select="$ProcessRole"/>
						</xsl:call-template>
					</_entities_element>		
				</xsl:for-each>
			</_entities>
		</entity>
	</xsl:template>
</xsl:stylesheet>
