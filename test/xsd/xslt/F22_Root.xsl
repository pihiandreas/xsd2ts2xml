<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:uuid="java:java.util.UUID"
	xmlns:enrich="java:com.cgi.cms.mhb.utl.mtc.enrich.XMLEnricher"
	exclude-result-prefixes="enrich uuid">

	<xsl:import href="F22_Payload.xsl" />

	<xsl:param name="TenantCode" select="'FGR'" />
	<xsl:param name="UserName" />
	<xsl:param name="UserIdentifier" />
	<xsl:param name="Channel" />
	<xsl:param name="ConfigVersion" />
	<xsl:param name="ProductVersion" />
	<xsl:param name="ReceivedTimestamp" />

	<xsl:output omit-xml-declaration="yes" indent="no" method="xml"
		encoding="utf-8" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>

	<!-- Skip the SOAP Envelope Header as we don't process it -->
	<xsl:template name="SOAPHeaderTemplate"	match="/*[local-name()='Envelope']/*[local-name()='Header']"/>

	<!-- Specific transaction template for each specific ebIX market message -->
	<xsl:template name="MessageTemplate"
		match="/*[local-name()='Envelope']/*[local-name()='Body']/*[local-name()='ProcessMessageRequest'] | /*[local-name()='Envelope']/*[local-name()='Body']/*[local-name()='SendMessageRequest']">
		<entity>
			<_name>Message</_name>
			<_type>MESSAGE</_type>
			<xsl:if test="//*[local-name()='Header']/*[local-name()='DocumentType']">
				<ExternalMessageType>
					<xsl:value-of select="//*[local-name()='Header']/*[local-name()='DocumentType']" />
				</ExternalMessageType>
			</xsl:if>
			<xsl:if test="//*[local-name()='Header']/*[local-name()='Identification']">
				<ExternalMessageID>
					<xsl:value-of select="//*[local-name()='Header']/*[local-name()='Identification']" />
				</ExternalMessageID>
			</xsl:if>
			<xsl:if test="//*[local-name()='Header']/*[local-name()='SenderRoutingInformation'] ">
				<ExternalMessageReference>
					<xsl:value-of select="//*[local-name()='Header']/*[local-name()='SenderRoutingInformation']" />
				</ExternalMessageReference>
			</xsl:if>
			<xsl:if test="//*[local-name()='Header']/*[local-name()='Creation']">
				<MessageTimestamp>
					<xsl:value-of select="replace(//*[local-name()='Header']/*[local-name()='Creation'], '\+00:00', 'Z')"/>
				</MessageTimestamp>
			</xsl:if>
			<xsl:if test="//*[local-name()='Header']/*[local-name()='PhysicalSenderEnergyParty']/*[local-name()='Identification']">
				<PhysicalSender>
					<xsl:value-of select="//*[local-name()='Header']/*[local-name()='PhysicalSenderEnergyParty']/*[local-name()='Identification']" />
				</PhysicalSender>
			</xsl:if>
			<xsl:variable name="JuridicalSender" select="//*[local-name()='Header']/*[local-name()='JuridicalSenderEnergyParty']/*[local-name()='Identification']" />
			<xsl:if test="$JuridicalSender">
				<JuridicalSender>
					<xsl:value-of select="$JuridicalSender" />
				</JuridicalSender>
			</xsl:if>
			<xsl:variable name="ProcessRole" select="//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcessRole']" />
			<xsl:if test="$ProcessRole">
				<ProcessRole>
					<xsl:value-of select="$ProcessRole" />
				</ProcessRole>
			</xsl:if>
			<xsl:if test="//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyIndustryClassification']">
				<Industry>
					<xsl:value-of select="//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyIndustryClassification']" />
				</Industry>
			</xsl:if>
			<xsl:if test="//*[local-name()='Header']/*[local-name()='PhysicalReceiverEnergyParty']/*[local-name()='Identification']">
				<PhysicalReceiver>
					<xsl:value-of select="//*[local-name()='Header']/*[local-name()='PhysicalReceiverEnergyParty']/*[local-name()='Identification']" />
				</PhysicalReceiver>
			</xsl:if>
			<xsl:if test="//*[local-name()='Header']/*[local-name()='JuridicalReceiverEnergyParty']/*[local-name()='Identification'] ">
				<JuridicalReceiver>
					<xsl:value-of select="//*[local-name()='Header']/*[local-name()='JuridicalReceiverEnergyParty']/*[local-name()='Identification']" />
				</JuridicalReceiver>
			</xsl:if>
			<xsl:variable name="MarketRole" select="enrich:getMarketRole($JuridicalSender, $UserName, $TenantCode, $ProcessRole)"/>
			<xsl:if test="$MarketRole">
				<MarketRole>
					<xsl:value-of select="$MarketRole" />
				</MarketRole>
			</xsl:if>
			<_entities>
				<_entities_element>
					<_name>MessageHeader</_name>
					<_type>MESSAGE_HEADER</_type>
					<xsl:choose>
						<xsl:when test="/*[local-name()='Envelope']/*[local-name()='Body']/*[local-name() = 'SendMessageRequest']">
							<InternalMessageType>MSG.SND</InternalMessageType>
						</xsl:when>
						<xsl:otherwise>							
							<InternalMessageType>MSG.PRC</InternalMessageType>
						</xsl:otherwise>
					</xsl:choose>							
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
						<xsl:value-of select="replace($ReceivedTimestamp, '\+00:00', 'Z')"/>
					</ReceivedTimestamp>
					<xsl:variable name="PhysicalSenderID" select="enrich:getOrganisationID(//*[local-name()='Header']/*[local-name()='PhysicalSenderEnergyParty']/*[local-name()='Identification'], $TenantCode, $ProcessRole, '')"/>
					<PhysicalSenderID>
						<xsl:value-of select="$PhysicalSenderID" />
					</PhysicalSenderID>
					<JuridicalSenderID>
						<xsl:choose>
							<xsl:when test="$JuridicalSender">
								<xsl:value-of select="enrich:getOrganisationID($JuridicalSender, $TenantCode, $ProcessRole, '')" />
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

				<_entities_element>
					<_name>Transaction</_name>
					<_type>TRANSACTION</_type>
					<xsl:if test="//*[local-name()='Header']/*[local-name()='Identification']">
						<ExternalTransactionID>
							<xsl:value-of select="//*[local-name()='Header']/*[local-name()='Identification']" />
						</ExternalTransactionID>
					</xsl:if>
					<xsl:if	test="//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']">
						<ExternalTransactionType>
							<xsl:value-of
								select="//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']" />
						</ExternalTransactionType>
					</xsl:if>
					<_entities>
						<_entities_element>
							<_name>TransactionHeader</_name>
							<_type>TRANSACTION_HEADER</_type>
							<xsl:if test=".//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']">
								<InternalTransactionType>
									<xsl:choose>
										<xsl:when test=".//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']='DH-713'">PRC.UPS</xsl:when>
										<xsl:when test=".//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']='DH-714'">PRC.UPD</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select=".//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']" />
										</xsl:otherwise>
									</xsl:choose>
								</InternalTransactionType>
							</xsl:if>
							<xsl:if test=".//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']">
								<PayloadType>
									<xsl:choose>
										<xsl:when test=".//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']='DH-713'">PRC.UPS.REQ</xsl:when>
										<xsl:when test=".//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']='DH-714'">PRC.UPD.REQ</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select=".//*[local-name()='ProcessEnergyContext']/*[local-name()='EnergyBusinessProcess']" />
										</xsl:otherwise>
									</xsl:choose>
								</PayloadType>
							</xsl:if>
							<InternalTransactionID>
								<xsl:value-of select="uuid:randomUUID()" />
							</InternalTransactionID>
						</_entities_element>
						<_entities_element>
							<_name>Payload</_name>
							<_type>PAYLOAD</_type>
							<_entities>
								<_entities_element>
									<_name>TransactionPayload</_name>
									<_type>F22_TRP</_type>
									<xsl:if test=".//*[local-name()='Transaction']/*[local-name()='PriceValidityTime']/*[local-name()='Start']">
										<StartOfOccurrence>
											<xsl:value-of select="replace(.//*[local-name()='Transaction']/*[local-name()='PriceValidityTime']/*[local-name()='Start'], '\+00:00', 'Z')" />
										</StartOfOccurrence>
									</xsl:if>
									<xsl:if test=".//*[local-name()='Transaction']/*[local-name()='PriceValidityTime']/*[local-name()='End']">
										<EndOfOccurrence>
											<xsl:value-of select="replace(.//*[local-name()='Transaction']/*[local-name()='PriceValidityTime']/*[local-name()='End'], '\+00:00', 'Z')" />
										</EndOfOccurrence>
									</xsl:if>
									<xsl:if test=".//*[local-name()='Transaction']/*[local-name()='OriginalBusinessDocumentReference']">
										<OriginalMessageID>
											<xsl:value-of select=".//*[local-name()='Transaction']/*[local-name()='OriginalBusinessDocumentReference']" />
										</OriginalMessageID>
									</xsl:if>
									<xsl:if test=".//*[local-name()='Transaction']/*[local-name()='OriginalBusinessDocumentSender']">
										<OriginalMessageSender>
											<xsl:value-of select=".//*[local-name()='Transaction']/*[local-name()='OriginalBusinessDocumentSender']" />
										</OriginalMessageSender>
									</xsl:if>
									<xsl:if test=".//*[local-name()='Transaction']/*[local-name()='Description']">
										<Description>
											<xsl:value-of select=".//*[local-name()='Transaction']/*[local-name()='Description']" />
										</Description>
									</xsl:if>
									<xsl:if test=".//*[local-name()='Transaction']/*[local-name()='TransferContractNeeded']">
										<IsNewGridAgreementRequired>
											<xsl:choose>
												<xsl:when test=".//*[local-name()='Transaction']/*[local-name()='TransferContractNeeded']='0' or .//*[local-name()='Transaction']/*[local-name()='TransferContractNeeded']='false'">false</xsl:when>
												<xsl:otherwise>true</xsl:otherwise>
											</xsl:choose>	
										</IsNewGridAgreementRequired>
									</xsl:if>
 									
								</_entities_element>
								<_entities_element>
									<xsl:apply-templates />
								</_entities_element>
							</_entities>
						</_entities_element>
					</_entities>
				</_entities_element>

			</_entities>
		</entity>
	</xsl:template>
	<!-- do nothing for unmatched text or attribute nodes -->
	<xsl:template match="text()|@*" />

</xsl:stylesheet>