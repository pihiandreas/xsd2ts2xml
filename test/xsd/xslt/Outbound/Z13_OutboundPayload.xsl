<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:urn17="urn:ediel:org:masterdata:resourceobjectmasterdatadocument:1:3">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:template match="entity">
		<urn17:NEGResourceObjectMasterDataDocument>
			<xsl:if test="ExternalMessageID">
				<urn17:DocumentIdentification>
					<xsl:attribute name="v">
						<xsl:value-of select="ExternalMessageID"/>
					</xsl:attribute>
				</urn17:DocumentIdentification>
			</xsl:if>
			<xsl:if test=".//*[_type='HPM']/DocumentType">
				<urn17:DocumentType>
					<xsl:attribute name="v">
						<xsl:value-of select=".//*[_type='HPM']/DocumentType"/>
					</xsl:attribute>
				</urn17:DocumentType>
			</xsl:if>
			<xsl:if test=".//*[_type='HPM']/ProcessType">
				<urn17:ProcessType>
					<xsl:attribute name="v">
						<xsl:value-of select=".//*[_type='HPM']/ProcessType"/>
					</xsl:attribute>
				</urn17:ProcessType>
			</xsl:if>
			<xsl:if test="JuridicalSender">
				<urn17:SenderIdentification>
					<xsl:attribute name="v">
						<xsl:value-of select="JuridicalSender"/>
					</xsl:attribute>
					<xsl:attribute name="codingScheme">A10</xsl:attribute>
				</urn17:SenderIdentification>
			</xsl:if>
			<xsl:if test=".//*[_type='HPM']/SenderRole">
				<urn17:SenderRole>
					<xsl:attribute name="v">
						<xsl:value-of select=".//*[_type='HPM']/SenderRole"/>
					</xsl:attribute>
				</urn17:SenderRole>
			</xsl:if>
			<xsl:if test="JuridicalReceiver">
				<urn17:ReceiverIdentification>
					<xsl:attribute name="v">
						<xsl:value-of select="JuridicalReceiver"/>
					</xsl:attribute>
					<xsl:attribute name="codingScheme">A01</xsl:attribute>
				</urn17:ReceiverIdentification>
			</xsl:if>
			<xsl:if test=".//*[_type='HPM']/ReceiverRole">
				<urn17:ReceiverRole>
					<xsl:attribute name="v">
						<xsl:value-of select=".//*[_type='HPM']/ReceiverRole"/>
					</xsl:attribute>
				</urn17:ReceiverRole>
			</xsl:if>
			<xsl:if test=".//*[_type='HPM']/CreationDateTime">
				<urn17:CreationDateTime>
					<xsl:attribute name="v">
						<xsl:value-of select=".//*[_type='HPM']/CreationDateTime"/>
					</xsl:attribute>
				</urn17:CreationDateTime>
			</xsl:if>
			<xsl:for-each select=".//*[_type='VPU' or _type='PRU']">
				<urn17:ResourceObjectDetails>
					<xsl:if test="MeteringPointEAN">
						<urn17:ResourceObjectIdentification>
							<xsl:attribute name="v">
								<xsl:value-of select="MeteringPointEAN"/>
							</xsl:attribute>
							<xsl:attribute name="codingScheme">A10</xsl:attribute>
						</urn17:ResourceObjectIdentification>
					</xsl:if>
					<xsl:if test="ProductionUnitName">
						<urn17:ResourceObjectName>
							<xsl:attribute name="v">
								<xsl:value-of select="ProductionUnitName"/>
							</xsl:attribute>
						</urn17:ResourceObjectName>
					</xsl:if>
					<xsl:if test="ObjectAggregation">
						<urn17:ObjectAggregation>
							<xsl:attribute name="v">
								<xsl:value-of select="ObjectAggregation"/>
							</xsl:attribute>
						</urn17:ObjectAggregation>
					</xsl:if>
					<xsl:if test="Status">
						<urn17:Status>
							<xsl:attribute name="v">
								<xsl:value-of select="Status"/>
							</xsl:attribute>
						</urn17:Status>
					</xsl:if>
					<xsl:if test="ValidFromDate and MeteringPointStatus = 'AE01'">
						<urn17:ValidityStart>
							<xsl:attribute name="v">
								<xsl:value-of select="ValidFromDate"/>
							</xsl:attribute>
						</urn17:ValidityStart>
					</xsl:if>
					<xsl:if test="ValidFromDate and MeteringPointStatus = 'AE04'">
						<urn17:ValidityEnd>
							<xsl:attribute name="v">
								<xsl:value-of select="ValidFromDate"/>
							</xsl:attribute>
						</urn17:ValidityEnd>
					</xsl:if>
					<xsl:if test="ValidToDate and MeteringPointStatus != 'AE04'">
						<urn17:ValidityEnd>
							<xsl:attribute name="v">
								<xsl:value-of select="ValidToDate"/>
							</xsl:attribute>
						</urn17:ValidityEnd>
					</xsl:if>
					<xsl:if test="ProductionUnitType">
						<urn17:AssetType>
							<xsl:attribute name="v">
								<xsl:value-of select="ProductionUnitType"/>
							</xsl:attribute>
						</urn17:AssetType>
					</xsl:if>
					<xsl:if test="ProductionUnitClass">
						<urn17:ProductionType>
							<xsl:attribute name="v">
								<xsl:value-of select="ProductionUnitClass"/>
							</xsl:attribute>
						</urn17:ProductionType>
					</xsl:if>
					<xsl:if test="MeasureUnit">
						<urn17:MeasureUnit>
							<xsl:attribute name="v">
								<xsl:value-of select="MeasureUnit"/>
							</xsl:attribute>
						</urn17:MeasureUnit>
					</xsl:if>
					<xsl:if test="ElectricPower">
						<urn17:Capacity>
							<xsl:attribute name="v">
								<xsl:value-of select="ElectricPower"/>
							</xsl:attribute>
						</urn17:Capacity>
					</xsl:if>
					<xsl:if test="SupplierIdentifier or SubjectPartyRole">
						<urn17:PartyDetails>
							<xsl:if test="SupplierIdentifier">
								<urn17:SubjectParty>
									<xsl:attribute name="v">
										<xsl:value-of select="SupplierIdentifier"/>
									</xsl:attribute>
									<xsl:attribute name="codingScheme">A10</xsl:attribute>
								</urn17:SubjectParty>
							</xsl:if>
							<xsl:if test="SubjectPartyRole">
								<urn17:SubjectPartyRole>
									<xsl:attribute name="v">
										<xsl:value-of select="SubjectPartyRole"/>
									</xsl:attribute>
								</urn17:SubjectPartyRole>
							</xsl:if>
						</urn17:PartyDetails>
					</xsl:if>
					<xsl:if test="MeteringGridAreaCode or AreaType">
						<urn17:RelatedArea>
							<xsl:if test="MeteringGridAreaCode">
								<urn17:AreaIdentification>
									<xsl:attribute name="v">
										<xsl:value-of select="MeteringGridAreaCode"/>
									</xsl:attribute>
									<xsl:attribute name="codingScheme">A01</xsl:attribute>
								</urn17:AreaIdentification>
							</xsl:if>
							<xsl:if test="AreaType">
								<urn17:TypeOfArea>
									<xsl:attribute name="v">
										<xsl:value-of select="AreaType"/>
									</xsl:attribute>
								</urn17:TypeOfArea>
							</xsl:if>
						</urn17:RelatedArea>
					</xsl:if>
				</urn17:ResourceObjectDetails>
			</xsl:for-each>
		</urn17:NEGResourceObjectMasterDataDocument>
	</xsl:template>
</xsl:stylesheet>