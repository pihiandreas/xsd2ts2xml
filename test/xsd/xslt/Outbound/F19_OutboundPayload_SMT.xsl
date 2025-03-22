<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:urn1="urn:fi:Datahub:mif:metering:F19_BalanceCorrectionData:v1"
	xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1"
	xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1"
	xmlns:urn4="urn:fi:Datahub:mif:metering:F19_BalanceCorrectionData:elements:v1"
	xmlns:enrich="java:com.cgi.cms.mhb.utl.mtc.enrich.XMLEnricher"
	exclude-result-prefixes="enrich">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" />
	<xsl:template match="entity">
		<urn1:BalanceCorrectionDataMessage>
			<urn1:BalanceCorrectionData>
				<urn1:Header>
					<xsl:if test="ExternalMessageID">
						<urn2:Identification>
							<xsl:value-of select="ExternalMessageID" />
						</urn2:Identification>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="ExternalMessageType">
							<urn2:DocumentType>
								<xsl:value-of select="ExternalMessageType" />
							</urn2:DocumentType>
						</xsl:when>
						<xsl:otherwise>
							<urn2:DocumentType>F19</urn2:DocumentType>
						</xsl:otherwise>
					</xsl:choose>
					<urn2:Creation>
						<xsl:value-of select="enrich:getReceivedTimestamp()" />
					</urn2:Creation>
					<xsl:variable name="PhysicalSenderID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/PhysicalSenderID)"/>
					<urn2:PhysicalSenderEnergyParty>
						<xsl:if test="$PhysicalSenderID">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="$PhysicalSenderID" />
							</urn2:Identification>
						</xsl:if>
					</urn2:PhysicalSenderEnergyParty>
					<xsl:variable name="JuridicalSenderID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/JuridicalSenderID)"/>
					<urn2:JuridicalSenderEnergyParty>
						<xsl:if test="$JuridicalSenderID">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="$JuridicalSenderID" />
							</urn2:Identification>
						</xsl:if>
					</urn2:JuridicalSenderEnergyParty>
					<xsl:variable name="JuridicalReceiverID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/JuridicalReceiverID)"/>
					<urn2:JuridicalRecipientEnergyParty>
						<xsl:if test="$JuridicalReceiverID">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="$JuridicalReceiverID" />
							</urn2:Identification>
						</xsl:if>
					</urn2:JuridicalRecipientEnergyParty>
					<xsl:variable name="PhysicalReceiverID" select="enrich:getOrganisationIdentifier(.//*[_type='MESSAGE_HEADER']/PhysicalReceiverID)"/>
					<urn2:PhysicalRecipientEnergyParty>
						<xsl:if test="$PhysicalReceiverID">
							<urn2:Identification schemeAgencyIdentifier="9">
								<xsl:value-of select="$PhysicalReceiverID" />
							</urn2:Identification>
						</xsl:if>				
					</urn2:PhysicalRecipientEnergyParty>
					<xsl:if test="ExternalMessageReference">
						<urn2:SenderRoutingInformation>
							<xsl:value-of select="ExternalMessageReference" />
						</urn2:SenderRoutingInformation>
					</xsl:if>
					<xsl:if test="RelatedExternalMessageID">
						<urn2:OriginalBusinessDocumentReference>
							<xsl:value-of select="RelatedExternalMessageID" />
						</urn2:OriginalBusinessDocumentReference>
					</xsl:if>
					<xsl:if test="MessageNumber">
						<urn2:MessageNumber>
							<xsl:value-of select="MessageNumber" />
						</urn2:MessageNumber>
					</xsl:if>
					<xsl:if test="MessageCount">
						<urn2:MessagesTotal>
							<xsl:value-of select="MessageCount" />
						</urn2:MessagesTotal>
					</xsl:if>
					<xsl:if test="RegistrationTimestamp">
						<urn2:RegistrationTimestamp>
							<xsl:value-of select="RegistrationTimestamp" />
						</urn2:RegistrationTimestamp>
					</xsl:if>
				</urn1:Header>
				<urn1:ProcessEnergyContext>
					<!--EnergyBusinessProcess-->
					<xsl:if test="BusinessProcess">
						<xsl:choose>
							<xsl:when test="BusinessProcess='35'">
								<urn3:EnergyBusinessProcess>DH-611</urn3:EnergyBusinessProcess>
							</xsl:when>
							<xsl:when test="BusinessProcess='36'">
								<urn3:EnergyBusinessProcess>DH-612</urn3:EnergyBusinessProcess>
							</xsl:when>
							<xsl:otherwise>
								<urn3:EnergyBusinessProcess>
									<xsl:value-of select="BusinessProcess"/>
								</urn3:EnergyBusinessProcess>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>		
					<!--EnergyBusinessProcessRole-->
					<xsl:if test="ProcessRole">
						<xsl:choose>
							<xsl:when test="ProcessRole='1'">
								<urn3:EnergyBusinessProcessRole>EZ</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='2'">
								<urn3:EnergyBusinessProcessRole>DDM</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='3'">
								<urn3:EnergyBusinessProcessRole>DDM2</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='4'">
								<urn3:EnergyBusinessProcessRole>DDK</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='5'">
								<urn3:EnergyBusinessProcessRole>DDQ</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='6'">
								<urn3:EnergyBusinessProcessRole>DDX</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='7'">
								<urn3:EnergyBusinessProcessRole>DEA</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='8'">
								<urn3:EnergyBusinessProcessRole>MDR</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='9'">
								<urn3:EnergyBusinessProcessRole>SP</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:when test="ProcessRole='10'">
								<urn3:EnergyBusinessProcessRole>ESC</urn3:EnergyBusinessProcessRole>
							</xsl:when>
							<xsl:otherwise>
								<urn3:EnergyBusinessProcessRole>
									<xsl:value-of select="ProcessRole" />
								</urn3:EnergyBusinessProcessRole>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<!--EnergyIndustryClassification-->
					<xsl:choose>
						<xsl:when test="Industry">
							<xsl:choose>
								<xsl:when test="Industry='1'">
									<urn3:EnergyIndustryClassification>23</urn3:EnergyIndustryClassification>
								</xsl:when>
								<xsl:otherwise>
									<urn3:EnergyIndustryClassification>
										<xsl:value-of select="Industry"/>
									</urn3:EnergyIndustryClassification>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<urn3:EnergyIndustryClassification>23</urn3:EnergyIndustryClassification>
						</xsl:otherwise>
					</xsl:choose>	
				</urn1:ProcessEnergyContext>
				<xsl:variable name="RegistrationTimestamp" select="RegistrationTimestamp"/>
				<xsl:for-each select=".//*[_type='TRANSACTION']">
					<urn1:Transaction>
						<urn4:Identification>
							<xsl:value-of select="ExternalTransactionID" />
						</urn4:Identification>
						<urn4:MeteringGridAreaUsedDomainLocation>
							<urn4:Identification schemeAgencyIdentifier="305"> 
								<xsl:value-of select=".//*[_type='STS']/MeteringGridArea"/>
							</urn4:Identification>
						</urn4:MeteringGridAreaUsedDomainLocation>
						<xsl:if test=".//*[_type='STS']/Supplier">
							<urn4:BalanceSupplierInvolvedEnergyParty>
								<urn4:Identification schemeAgencyIdentifier="9"> 
									<xsl:value-of select="enrich:getOrganisationIdentifier(.//*[_type='STS']/Supplier)"/>
								</urn4:Identification>
							</urn4:BalanceSupplierInvolvedEnergyParty>
						</xsl:if>
						<urn4:BalanceCalculationDateTime>
							<xsl:value-of select="$RegistrationTimestamp"/>
						</urn4:BalanceCalculationDateTime>
						<urn4:DeviationType listAgencyIdentifier="NFI">
							<xsl:choose>
								<xsl:when test=".//*[_type='STS']/TimeSeriesType='BD_BCD_SUP' or .//*[_type='STS']/TimeSeriesType='BD_TOT_SUP_MGA_SUP'">AU01</xsl:when>
								<xsl:otherwise>AU02</xsl:otherwise>
							</xsl:choose>
						</urn4:DeviationType>
						<urn4:ObservationPeriod>
							<urn4:Start>
								<xsl:value-of select="/*[_type='MESSAGE']/SettlementPeriodStartTS"/>
							</urn4:Start>
							<urn4:End>
								<xsl:value-of select="/*[_type='MESSAGE']/SettlementPeriodEndTS"/>
							</urn4:End>
						</urn4:ObservationPeriod>
						<xsl:choose>
							<xsl:when test=".//*[_type='STS']/TimeSeriesType='BD_TOT_SUP_MGA_SUP' or .//*[_type='STS']/TimeSeriesType='BD_TOT_LOSS_MGA_SUP'">
								<urn4:TotalSums>
										<urn4:TotalAmount>
											<xsl:value-of select=".//*[_type='STS']/amount"/>
										</urn4:TotalAmount>
										<urn4:Energy>
											<xsl:value-of select=".//*[_type='STS']/deltaQty"/>
										</urn4:Energy>
									</urn4:TotalSums>
							</xsl:when>
							<xsl:otherwise>
								<urn4:BalanceCorrectionDetails>
									<xsl:if test=".//*[_type='STS']/TimeSeriesType='BD_BCD_SUP'">
										<urn4:MeteringPoint schemeAgencyIdentifier="9">
											<xsl:value-of select=".//*[_type='STS']/MeteringPointID"/>
										</urn4:MeteringPoint>
									</xsl:if>
									<xsl:choose>
										<xsl:when test=".//*[_type='STS']/apType='1'">
											<urn4:MeteringPointType listAgencyIdentifier="NFI">AG01</urn4:MeteringPointType>
										</xsl:when>
										<xsl:when test=".//*[_type='STS']/apType='2'">
											<urn4:MeteringPointType listAgencyIdentifier="NFI">AG02</urn4:MeteringPointType>
										</xsl:when>
									</xsl:choose>
									<xsl:if test=".//*[_type='STS']/meteringMethod">
										<xsl:choose>
											<xsl:when test=".//*[_type='STS']/meteringMethod='1'">
												<urn4:MeteringMethod>E13</urn4:MeteringMethod>
											</xsl:when>
											<xsl:when test=".//*[_type='STS']/meteringMethod='2'">
												<urn4:MeteringMethod>E14</urn4:MeteringMethod>
											</xsl:when>
											<xsl:when test=".//*[_type='STS']/meteringMethod='3'">
												<urn4:MeteringMethod>E16</urn4:MeteringMethod>
											</xsl:when>
										</xsl:choose>
									</xsl:if>
									<xsl:variable name="TimeSeriesType" select=".//*[_type='STS']/TimeSeriesType"/>
									<xsl:for-each select=".//*[_type='OBS']">
										<urn4:Values>
											<urn4:DT>
												<xsl:value-of select="readTS"/>
											</urn4:DT>
											<xsl:if test="$TimeSeriesType='BD_BCD_SUP'">
												<xsl:choose>
													<xsl:when test="oldQty=''">
														<urn4:OldQty>0</urn4:OldQty>
													</xsl:when>
													<xsl:otherwise>
														<urn4:OldQty>
															<xsl:value-of select="oldQty"/>
														</urn4:OldQty>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:if>
											<xsl:if test="$TimeSeriesType='BD_BCD_SUP'">
												<urn4:NewQty>
													<xsl:value-of select="newQty"/>
												</urn4:NewQty>
											</xsl:if>
											<urn4:DeltaQty>
												<xsl:value-of select="deltaQty"/>
											</urn4:DeltaQty>
											<urn4:Price>
												<xsl:value-of select="price"/>
											</urn4:Price>
											<xsl:choose>
												<xsl:when test="res='-2'">
													<urn4:RD>PT1S</urn4:RD>
												</xsl:when>
												<xsl:when test="res='-3'">
													<urn4:RD>PT1M</urn4:RD>
												</xsl:when>
												<xsl:when test="res='-4'">
													<urn4:RD>PT5M</urn4:RD>
												</xsl:when>
												<xsl:when test="res='-5'">
													<urn4:RD>PT10M</urn4:RD>
												</xsl:when>
												<xsl:when test="res='-6'">
													<urn4:RD>PT15M</urn4:RD>
												</xsl:when>
												<xsl:when test="res='-7'">
													<urn4:RD>PT30M</urn4:RD>
												</xsl:when>
												<xsl:when test="res='-8'">
													<urn4:RD>PT1H</urn4:RD>
												</xsl:when>
												<xsl:when test="res='-101'">
													<urn4:RD>P1D</urn4:RD>
												</xsl:when>
												<xsl:when test="res='-102'">
													<urn4:RD>P1M</urn4:RD>
												</xsl:when>
												<xsl:when test="res='-103'">
													<urn4:RD>P3M</urn4:RD>
												</xsl:when>
												<xsl:when test="res='-104'">
													<urn4:RD>P1Y</urn4:RD>
												</xsl:when>
											</xsl:choose>
											<xsl:if test="$TimeSeriesType='BD_BCD_SUP'">
												<urn4:RS>
													<xsl:choose>
														<xsl:when test="reason='MDC'">BL01</xsl:when>
														<xsl:when test="reason='SUP'">BL02</xsl:when>
														<xsl:when test="reason='BOTH'">BL03</xsl:when>
													</xsl:choose>
												</urn4:RS>
											</xsl:if>
										</urn4:Values>
									</xsl:for-each>
								</urn4:BalanceCorrectionDetails>
							</xsl:otherwise>
						</xsl:choose>
					</urn1:Transaction>
				</xsl:for-each>
			</urn1:BalanceCorrectionData>
		</urn1:BalanceCorrectionDataMessage>
	</xsl:template>
</xsl:stylesheet>