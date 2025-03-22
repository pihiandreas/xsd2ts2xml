<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:uuid="java:java.util.UUID"
	xmlns:enrich="java:com.cgi.cms.mhb.utl.mtc.enrich.XMLEnricher"
	exclude-result-prefixes="enrich uuid">

	<xsl:import href="Z-ACK_Payload.xsl" />

	<xsl:param name="TenantCode" select="'FGR'" />
	<xsl:param name="UserName" />
	<xsl:param name="UserIdentifier" />
	<xsl:param name="Channel" />
	<xsl:param name="ConfigVersion" />
	<xsl:param name="ProductVersion" />

	<xsl:output omit-xml-declaration="yes" indent="no" method="xml"
		encoding="utf-8" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>

	<!-- Skip the SOAP Envelope Header as we don't process it -->
	<xsl:template name="SOAPHeaderTemplate"	match="/*[local-name()='Envelope']/*[local-name()='AcknowledgementDocument']"/>

	<!-- Specific transaction template for each specific ebIX market message -->
	<xsl:template name="MessageTemplate"
		match="/*[local-name()='Envelope']/*[local-name()='Body']/*[local-name()='ProcessMessageRequest'] | /*[local-name()='Envelope']/*[local-name()='Body']/*[local-name()='SendMessageRequest']">
		<entity>
			<_name>Message</_name>
			<_type>MESSAGE</_type>
			<xsl:if test="//*[local-name()='AcknowledgementDocument']/*[local-name()='DocumentIdentification']">
				<ExternalMessageID>
					<xsl:value-of select="//*[local-name()='AcknowledgementDocument']/*[local-name()='DocumentIdentification']/@v" />
				</ExternalMessageID>
				<ExternalMessageType>ISR.ACK</ExternalMessageType>
				<MarketRole>MOP</MarketRole>
				<xsl:variable name="Sender" select="//*[local-name()='AcknowledgementDocument']/*[local-name()='SenderIdentification']/@v" />
				<PhysicalSender>
					<xsl:value-of select="$Sender" />
				</PhysicalSender>
				<JuridicalSender>
					<xsl:value-of select="$Sender" />
				</JuridicalSender>
				<!-- SMT specific attributes-->
				<xsl:if test="substring(//*[local-name()='AcknowledgementDocument']/*[local-name()='ReceivingDocumentIdentification']/@v, 1,3)='SMT'">
					<RelatedExternalMessageID>
						<xsl:value-of select="//*[local-name()='AcknowledgementDocument']/*[local-name()='ReceivingDocumentIdentification']/@v" />
					</RelatedExternalMessageID>
					<InternalTransactionType>ACK</InternalTransactionType>		
				</xsl:if>
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
					<xsl:if test="enrich:getReceivedTimestamp()">
						<ReceivedTimestamp>
							<xsl:value-of select="enrich:getReceivedTimestamp()" />
						</ReceivedTimestamp>
					</xsl:if>
					<TenantCode>
						<xsl:value-of select="$TenantCode" />
					</TenantCode>
					<xsl:variable name="OrganisationUserID" select="$UserName"/>
					<OrganisationUserID>
						<xsl:value-of select="enrich:getOrganisationUserID($UserName, $TenantCode)"/>
					</OrganisationUserID>
					<xsl:variable name="Sender" select="//*[local-name()='AcknowledgementDocument']/*[local-name()='SenderIdentification']/@v" />
					<PhysicalSenderID>
						<xsl:value-of select="enrich:getOrganisationID($Sender, $TenantCode, 'DDX', '')" />
					</PhysicalSenderID>		
					<JuridicalSenderID>
						<xsl:value-of select="enrich:getOrganisationID($Sender, $TenantCode, 'DDX', '')" />
					</JuridicalSenderID>					
					<xsl:variable name="UserIdentityID" select="enrich:getUserIdentityID($UserIdentifier)"/>
					<UserIdentityID>
						<xsl:value-of select="$UserIdentityID" />
					</UserIdentityID>
					<Channel>
						<xsl:value-of select="$Channel" />
					</Channel>
				</_entities_element>
				<_entities_element>
					<_name>Transaction</_name>
					<_type>TRANSACTION</_type>
					<ExternalTransactionType>ISR.ACK</ExternalTransactionType>
					<ExternalTransactionID>
						<xsl:value-of select="//*[local-name()='AcknowledgementDocument']/*[local-name()='DocumentIdentification']/@v" />
					</ExternalTransactionID>
					<_entities>
						<_entities_element>
							<_name>TransactionHeader</_name>
							<_type>TRANSACTION_HEADER</_type>
							<xsl:choose>
								<xsl:when test="substring(//*[local-name()='AcknowledgementDocument']/*[local-name()='ReceivingDocumentIdentification']/@v, 1,3)='CMD'">
									<InternalTransactionType>ISR.ACK</InternalTransactionType>								
								</xsl:when>
								<xsl:when test="substring(//*[local-name()='AcknowledgementDocument']/*[local-name()='ReceivingDocumentIdentification']/@v, 1,3)='SMT'">
									<InternalTransactionType>SMT.ACK</InternalTransactionType>								
								</xsl:when>
								<xsl:otherwise>
									<!-- The Internal Transaction Types for other acknowledgement message intended for other domains are not yet decided -->
									<InternalTransactionType>XXX</InternalTransactionType>
								</xsl:otherwise>
							</xsl:choose>
							<InternalTransactionID>
								<xsl:value-of select="uuid:randomUUID()" />
							</InternalTransactionID>
							<xsl:if test="substring(//*[local-name()='AcknowledgementDocument']/*[local-name()='ReceivingDocumentIdentification']/@v, 1,3)='SMT'">
								<PayloadType>ACK</PayloadType>		
							</xsl:if>	
						</_entities_element>
						<_entities_element>
							<xsl:choose>
								<xsl:when test="substring(//*[local-name()='AcknowledgementDocument']/*[local-name()='ReceivingDocumentIdentification']/@v, 1,3)='CMD'">
									<xsl:apply-templates mode="CMD"/>									
								</xsl:when >
								<xsl:otherwise>
									<xsl:apply-templates mode="SMT"/>
								</xsl:otherwise>
							</xsl:choose>
						</_entities_element>
					</_entities>
				</_entities_element>
			</_entities>
		</entity>
	</xsl:template>
	<!-- do nothing for unmatched text or attribute nodes -->
	<xsl:template match="text()|@*" />
</xsl:stylesheet>