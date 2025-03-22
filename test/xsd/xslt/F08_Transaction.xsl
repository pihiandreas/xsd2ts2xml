<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:uuid="java:java.util.UUID" xmlns:enrich="java:com.cgi.cms.mhb.utl.mtc.enrich.XMLEnricher" exclude-result-prefixes="enrich uuid" xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope" xmlns:urn="urn:cms:b2b:v01" xmlns:urn1="urn:fi:Datahub:mif:metering:F08_RequestMeasuredDataInfo:v1" xmlns:urn2="urn:fi:Datahub:mif:common:HDR_Header:elements:v1" xmlns:urn3="urn:fi:Datahub:mif:common:PEC_ProcessEnergyContext:elements:v1" xmlns:urn4="urn:fi:Datahub:mif:metering:F08_RequestMeasuredDataInfo:elements:v1">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>
	<xsl:template name="RequestMeasuredDataInfoTransactionTemplate" match="urn1:RequestMeasuredDataInfo">
		<_name>Transaction</_name>
		<_type>TRANSACTION</_type>
		<xsl:if test="urn1:Header/urn2:Identification">
			<ExternalTransactionID>
				<xsl:value-of select="urn1:Header/urn2:Identification"/>
			</ExternalTransactionID>
		</xsl:if>
		<xsl:element name="ExternalTransactionType">
			<xsl:value-of select="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess"/>
		</xsl:element>
		<_entities>
			<_entities_element>
				<_name>TransactionHeader</_name>
				<_type>TRANSACTION_HEADER</_type>
				<!--For MHB only -->
				<xsl:variable name="ProcessRole" select="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcessRole"/>
				<xsl:if test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess">
					<InternalTransactionType>
						<xsl:choose>
							<xsl:when test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess='DH-221' and $ProcessRole='DDQ'">ETS.RTR</xsl:when>
							<xsl:when test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess='DH-222' and $ProcessRole='MDR'">ETS.RTR</xsl:when>
							<xsl:when test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess='DH-223' and $ProcessRole='ESC'">ETS.RTR</xsl:when>
							<xsl:when test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess='DH-241' and $ProcessRole='DDQ'">ETS.RTR</xsl:when>
							<xsl:when test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess='DH-242' and $ProcessRole='MDR'">ETS.RTR</xsl:when>
							<xsl:when test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess='DH-243' and $ProcessRole='ESC'">ETS.RTR</xsl:when>							
							<xsl:when test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess='DH-261' and $ProcessRole='DDQ'">ETS.RTR</xsl:when>	
							<xsl:when test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess='DH-262' and $ProcessRole='MDR'">ETS.RTR</xsl:when>
							<xsl:when test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess='DH-263' and $ProcessRole='ESC'">ETS.RTR</xsl:when>														
							<xsl:when test="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess='DH-523' and $ProcessRole='MDR'">ETS.RTR</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess"/>
							</xsl:otherwise>
						</xsl:choose>
					</InternalTransactionType>
				</xsl:if>
				<InternalTransactionID>
					<xsl:value-of select="uuid:randomUUID()"/>
				</InternalTransactionID>
				<PayloadType>RETS</PayloadType>
			</_entities_element>
			<_entities_element>
				<_name>Payload</_name>
				<_type>PAYLOAD</_type>
				<_entities>
					<_entities_element>
						<_name>TransactionPayload</_name>
						<_type>RETS</_type>
						<xsl:variable name="EnergyBusinessProcess" select="urn1:ProcessEnergyContext/urn3:EnergyBusinessProcess"/>
						<xsl:element name="PeriodStartTS">
							<xsl:value-of select="urn1:Transaction/urn4:RequestPeriod/urn4:Start"/>
						</xsl:element>
						<xsl:element name="PeriodEndTS">
							<xsl:value-of select="urn1:Transaction/urn4:RequestPeriod/urn4:End"/>
						</xsl:element>
						<xsl:if test="urn1:Transaction/urn4:ResolutionDuration">
							<ResolutionDuration>	
								<xsl:value-of select="urn1:Transaction/urn4:ResolutionDuration"/>
							</ResolutionDuration>
						</xsl:if>
						<xsl:if test="urn1:Transaction/urn4:InvoiceRelevant">
							<xsl:element name="SettlementRelevant">
								<xsl:value-of select="urn1:Transaction/urn4:InvoiceRelevant"/>
							</xsl:element>
						</xsl:if>
						<_entities>
							<!--MeteringPointType-->
							<xsl:for-each select="urn1:Transaction/urn4:MeteringPoint/urn4:MeteringPointType">
								<_entities_element>
									<_name>MeteringPointType</_name>
									<_type>MPT</_type>
									<!-- MeteringPointType:	UNKNOWN	0	Unknown
										E17	1	Consumption metering point
										E18	2	Production metering point
										E19	3	Combined consumption and production metering point
										E20	4	Exchange metering point
										F01	5	Accounting point-->
									<MeteringPointType>
										<xsl:choose>	
											<!-- Fixed F01 for DH-523 -->										
											<xsl:when test="$EnergyBusinessProcess='DH-523'">F01</xsl:when> 
											<xsl:otherwise>
												<xsl:value-of select="."/>
											</xsl:otherwise>
										</xsl:choose>
									</MeteringPointType>
								</_entities_element>
							</xsl:for-each>
							<!--AccountingPointType-->
							<xsl:for-each select="urn1:Transaction/urn4:MeteringPoint/urn4:AccountingPointType">
								<_entities_element>
									<_name>AccountingPointType</_name>
									<_type>APT</_type>
									<!-- AccountingPointType:	UNKNOWN	0	Unknown
										AG01	1	Consumption accounting point
										AG02	2	Production accounting point-->
									<AccountingPointType>
										<xsl:value-of select="."/>
									</AccountingPointType>
								</_entities_element>
							</xsl:for-each>
							<!--MeteringPoint-->
							<xsl:for-each select="urn1:Transaction/urn4:MeteringPoint/urn4:Identification">
								<_entities_element>
									<_name>MeteringPoint</_name>
									<_type>MP</_type>
									<xsl:element name="MeteringPointID">
										<xsl:value-of select="."/>
									</xsl:element>
								</_entities_element>
							</xsl:for-each>
							<!--MeteringGridArea-->
							<xsl:for-each select="urn1:Transaction/urn4:MeteringPoint/urn4:MeteringArea">
								<_entities_element>
									<_name>MeteringArea</_name>
									<_type>MGA</_type>
									<xsl:element name="MeteringGridArea">
										<xsl:value-of select="."/>
									</xsl:element>
								</_entities_element>
							</xsl:for-each>
							<!--Product-->
							<xsl:for-each select="urn1:Transaction/urn4:Product">
								<!--ProductType:	unknown (0)
								8716867000030(1) //Active energy
								8716867000139(2) //Reactive energy input
								8716867000146(3) //Reactive energy output
								8716867000047(4) //Reactive energy -->
								<xsl:variable name="PRODUCT_TYPE">	
									<xsl:choose>
										<!-- Fixed 8716867000030 for DH-523-->
										<xsl:when test="$EnergyBusinessProcess='DH-523'">8716867000030</xsl:when>
										<xsl:otherwise>
											<xsl:if test="urn4:ProductIdentification">
												<xsl:value-of select="./urn4:ProductIdentification"/>
											</xsl:if>	
										</xsl:otherwise>
									</xsl:choose>									
								</xsl:variable>
								<!--UnitType: 	UNKNOWN(0), // Unknown
								KWH(6), // Kilowatt hours (kWh)
								KVARH(8), // Kilo volt-amp reactive hours (kvarh)
								WH(64), // Watt hours (Wh)
								MWH(65), // Megawatt hours (MWh)
								GWH(66), // Gigawatt hours (GWh)
								VARH(67), // Volt-amp reactive hours (varh)
								MVARH(70); // Megavolt-amp reactive hours (Mvarh)
								GVARH(71); // Gigavolt-amp reactive hours (Gvarh):#19934
								-->
								<xsl:variable name="UNIT_TYPE">
									<xsl:if test="./urn4:UnitType">
										<xsl:value-of select="./urn4:UnitType"/>
									</xsl:if>
								</xsl:variable>
								<_entities_element>
									<_name>Product</_name>
									<_type>PRT</_type>			
									<xsl:if test="$PRODUCT_TYPE">
										<ProductType>
											<xsl:value-of select="$PRODUCT_TYPE"/>
										</ProductType>
									</xsl:if>
									<xsl:if test="$UNIT_TYPE">
										<UnitType>
											<xsl:value-of select="$UNIT_TYPE"/>
										</UnitType>
									</xsl:if>
								</_entities_element>	
								<!-- If product 4 is chosen, then also add the other reactive energy products-->
								<xsl:if test="$PRODUCT_TYPE='8716867000047'">
									<_entities_element>
										<_name>Product</_name>
										<_type>PRT</_type>
										<ProductType>8716867000139</ProductType>
										<xsl:if test="$UNIT_TYPE">
											<UnitType>
												<xsl:value-of select="$UNIT_TYPE"/>
											</UnitType>
										</xsl:if>
									</_entities_element>
									<_entities_element>
										<_name>Product</_name>
										<_type>PRT</_type>
										<ProductType>8716867000146</ProductType>
										<xsl:if test="$UNIT_TYPE">
											<UnitType>
												<xsl:value-of select="$UNIT_TYPE"/>
											</UnitType>
										</xsl:if>
									</_entities_element>
								</xsl:if>	
							</xsl:for-each>
							<!-- DH-523 specific -->
							<xsl:if test="$EnergyBusinessProcess='DH-523'">
								<xsl:if test="not(urn1:Transaction/urn4:MeteringPoint/urn4:MeteringPointType)">
									<_entities_element>
										<_name>MeteringPointType</_name>
										<_type>MPT</_type>
										<MeteringPointType>F01</MeteringPointType>
									</_entities_element>
								</xsl:if>
								<xsl:if test="not(urn1:Transaction/urn4:Product)">
									<_entities_element>
										<_name>Product</_name>
										<_type>PRT</_type>
										<ProductType>8716867000030</ProductType>
										<UnitType>kWh</UnitType>
									</_entities_element>
								</xsl:if>
								<_entities_element>
									<_name>AdvancedMDFilter</_name>
									<_type>MDF</_type>
									<AdvancedMasterDataFilter>(kxsSMPAttr.bsID=0Ni)</AdvancedMasterDataFilter>
								</_entities_element>
								<_entities_element>
									<_name>AdvancedSDFilter</_name>
									<_type>SDF</_type>
									<AdvancedSensorDataFilter>(val>0)</AdvancedSensorDataFilter>
								</_entities_element>
							</xsl:if>
							<!-- DH-22X specific -->
							<xsl:if test="$EnergyBusinessProcess='DH-221' or $EnergyBusinessProcess='DH-222' or $EnergyBusinessProcess='DH-223'">								
								<_entities_element>
									<_name>AdvancedMDFilter</_name>
									<_type>MDF</_type>
									<AdvancedMasterDataFilter>kxsChannel.isDerived = 0b</AdvancedMasterDataFilter>
								</_entities_element>
							</xsl:if>
							<!-- DH-24X specific -->
							<xsl:if test="$EnergyBusinessProcess='DH-241' or $EnergyBusinessProcess='DH-242' or $EnergyBusinessProcess='DH-243'">
								<_entities_element>
									<_name>AdvancedMDFilter</_name>
									<_type>MDF</_type>
									<AdvancedMasterDataFilter>kxsChannel.isDerived = 1b</AdvancedMasterDataFilter>
								</_entities_element>
								<_entities_element>
									<_name>ChannelNumber</_name>
									<_type>CHANNO</_type>
									<ChannelNumber>NETTED</ChannelNumber>
								</_entities_element>								
							</xsl:if>
							<!-- DH-26X specific -->
							<xsl:if test="$EnergyBusinessProcess='DH-261' or $EnergyBusinessProcess='DH-262' or $EnergyBusinessProcess='DH-263'">
								<_entities_element>
									<_name>AdvancedMDFilter</_name>
									<_type>MDF</_type>
									<AdvancedMasterDataFilter>kxsChannel.isDerived = 1b</AdvancedMasterDataFilter>
								</_entities_element>
								<_entities_element>
									<_name>ChannelNumber</_name>
									<_type>CHANNO</_type>
									<ChannelNumber>COMMUNITY</ChannelNumber>
								</_entities_element>
							</xsl:if>
						</_entities>
					</_entities_element>
				</_entities>
			</_entities_element>
		</_entities>
	</xsl:template>
</xsl:stylesheet>