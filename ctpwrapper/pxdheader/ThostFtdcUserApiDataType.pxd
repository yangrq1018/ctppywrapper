# encoding: utf-8

cdef extern from 'ThostFtdcUserApiDataType.h':
    cdef enum THOST_TE_RESUME_TYPE:
        THOST_TERT_RESTART = 0
        THOST_TERT_RESUME
        THOST_TERT_QUICK
    ctypedef char TThostFtdcTraderIDType[21]
    ctypedef char TThostFtdcInvestorIDType[13]
    ctypedef char TThostFtdcBrokerIDType[11]
    ctypedef char TThostFtdcBrokerAbbrType[9]
    ctypedef char TThostFtdcBrokerNameType[81]
    ctypedef char TThostFtdcExchangeInstIDType[31]
    ctypedef char TThostFtdcOrderRefType[13]
    ctypedef char TThostFtdcParticipantIDType[11]
    ctypedef char TThostFtdcUserIDType[16]
    ctypedef char TThostFtdcPasswordType[41]
    ctypedef char TThostFtdcClientIDType[11]
    ctypedef char TThostFtdcInstrumentIDType[31]
    ctypedef char TThostFtdcInstrumentCodeType[31]
    ctypedef char TThostFtdcMarketIDType[31]
    ctypedef char TThostFtdcProductNameType[21]
    ctypedef char TThostFtdcExchangeIDType[9]
    ctypedef char TThostFtdcExchangeNameType[61]
    ctypedef char TThostFtdcExchangeAbbrType[9]
    ctypedef char TThostFtdcExchangeFlagType[2]
    ctypedef char TThostFtdcMacAddressType[21]
    ctypedef char TThostFtdcSystemIDType[21]
    ctypedef char TThostFtdcExchangePropertyType
    ctypedef char TThostFtdcDateType[9]
    ctypedef char TThostFtdcTimeType[9]
    ctypedef char TThostFtdcLongTimeType[13]
    ctypedef char TThostFtdcInstrumentNameType[21]
    ctypedef char TThostFtdcSettlementGroupIDType[9]
    ctypedef char TThostFtdcOrderSysIDType[21]
    ctypedef char TThostFtdcTradeIDType[21]
    ctypedef char TThostFtdcCommandTypeType[65]
    ctypedef char TThostFtdcIPAddressType[16]
    ctypedef int TThostFtdcIPPortType
    ctypedef char TThostFtdcProductInfoType[11]
    ctypedef char TThostFtdcProtocolInfoType[11]
    ctypedef char TThostFtdcBusinessUnitType[21]
    ctypedef char TThostFtdcDepositSeqNoType[15]
    ctypedef char TThostFtdcIdentifiedCardNoType[51]
    ctypedef char TThostFtdcIdCardTypeType
    ctypedef char TThostFtdcOrderLocalIDType[13]
    ctypedef char TThostFtdcUserNameType[81]
    ctypedef char TThostFtdcPartyNameType[81]
    ctypedef char TThostFtdcErrorMsgType[81]
    ctypedef char TThostFtdcFieldNameType[2049]
    ctypedef char TThostFtdcFieldContentType[2049]
    ctypedef char TThostFtdcSystemNameType[41]
    ctypedef char TThostFtdcContentType[501]
    ctypedef char TThostFtdcInvestorRangeType
    ctypedef char TThostFtdcDepartmentRangeType
    ctypedef char TThostFtdcDataSyncStatusType
    ctypedef char TThostFtdcBrokerDataSyncStatusType
    ctypedef char TThostFtdcExchangeConnectStatusType
    ctypedef char TThostFtdcTraderConnectStatusType
    ctypedef char TThostFtdcFunctionCodeType
    ctypedef char TThostFtdcBrokerFunctionCodeType
    ctypedef char TThostFtdcOrderActionStatusType
    ctypedef char TThostFtdcOrderStatusType
    ctypedef char TThostFtdcOrderSubmitStatusType
    ctypedef char TThostFtdcPositionDateType
    ctypedef char TThostFtdcPositionDateTypeType
    ctypedef char TThostFtdcTradingRoleType
    ctypedef char TThostFtdcProductClassType
    ctypedef char TThostFtdcInstLifePhaseType
    ctypedef char TThostFtdcDirectionType
    ctypedef char TThostFtdcPositionTypeType
    ctypedef char TThostFtdcPosiDirectionType
    ctypedef char TThostFtdcSysSettlementStatusType
    ctypedef char TThostFtdcRatioAttrType
    ctypedef char TThostFtdcHedgeFlagType
    ctypedef char TThostFtdcBillHedgeFlagType
    ctypedef char TThostFtdcClientIDTypeType
    ctypedef char TThostFtdcOrderPriceTypeType
    ctypedef char TThostFtdcOffsetFlagType
    ctypedef char TThostFtdcForceCloseReasonType
    ctypedef char TThostFtdcOrderTypeType
    ctypedef char TThostFtdcTimeConditionType
    ctypedef char TThostFtdcVolumeConditionType
    ctypedef char TThostFtdcContingentConditionType
    ctypedef char TThostFtdcActionFlagType
    ctypedef char TThostFtdcTradingRightType
    ctypedef char TThostFtdcOrderSourceType
    ctypedef char TThostFtdcTradeTypeType
    ctypedef char TThostFtdcPriceSourceType
    ctypedef char TThostFtdcInstrumentStatusType
    ctypedef char TThostFtdcInstStatusEnterReasonType
    ctypedef int TThostFtdcOrderActionRefType
    ctypedef int TThostFtdcInstallCountType
    ctypedef int TThostFtdcInstallIDType
    ctypedef int TThostFtdcErrorIDType
    ctypedef int TThostFtdcSettlementIDType
    ctypedef int TThostFtdcVolumeType
    ctypedef int TThostFtdcFrontIDType
    ctypedef int TThostFtdcSessionIDType
    ctypedef int TThostFtdcSequenceNoType
    ctypedef int TThostFtdcCommandNoType
    ctypedef int TThostFtdcMillisecType
    ctypedef int TThostFtdcVolumeMultipleType
    ctypedef int TThostFtdcTradingSegmentSNType
    ctypedef int TThostFtdcRequestIDType
    ctypedef int TThostFtdcYearType
    ctypedef int TThostFtdcMonthType
    ctypedef int TThostFtdcBoolType
    ctypedef double TThostFtdcPriceType
    ctypedef char TThostFtdcCombOffsetFlagType[5]
    ctypedef char TThostFtdcCombHedgeFlagType[5]
    ctypedef double TThostFtdcRatioType
    ctypedef double TThostFtdcMoneyType
    ctypedef double TThostFtdcLargeVolumeType
    ctypedef short TThostFtdcSequenceSeriesType
    ctypedef short TThostFtdcCommPhaseNoType
    ctypedef char TThostFtdcSequenceLabelType[2]
    ctypedef double TThostFtdcUnderlyingMultipleType
    ctypedef int TThostFtdcPriorityType
    ctypedef char TThostFtdcContractCodeType[41]
    ctypedef char TThostFtdcCityType[51]
    ctypedef char TThostFtdcIsStockType[11]
    ctypedef char TThostFtdcChannelType[51]
    ctypedef char TThostFtdcAddressType[101]
    ctypedef char TThostFtdcZipCodeType[7]
    ctypedef char TThostFtdcTelephoneType[41]
    ctypedef char TThostFtdcFaxType[41]
    ctypedef char TThostFtdcMobileType[41]
    ctypedef char TThostFtdcEMailType[41]
    ctypedef char TThostFtdcMemoType[161]
    ctypedef char TThostFtdcCompanyCodeType[51]
    ctypedef char TThostFtdcWebsiteType[51]
    ctypedef char TThostFtdcTaxNoType[31]
    ctypedef char TThostFtdcBatchStatusType
    ctypedef char TThostFtdcPropertyIDType[33]
    ctypedef char TThostFtdcPropertyNameType[65]
    ctypedef char TThostFtdcLicenseNoType[51]
    ctypedef char TThostFtdcAgentIDType[13]
    ctypedef char TThostFtdcAgentNameType[41]
    ctypedef char TThostFtdcAgentGroupIDType[13]
    ctypedef char TThostFtdcAgentGroupNameType[41]
    ctypedef char TThostFtdcReturnStyleType
    ctypedef char TThostFtdcReturnPatternType
    ctypedef char TThostFtdcReturnLevelType
    ctypedef char TThostFtdcReturnStandardType
    ctypedef char TThostFtdcMortgageTypeType
    ctypedef char TThostFtdcInvestorSettlementParamIDType
    ctypedef char TThostFtdcExchangeSettlementParamIDType
    ctypedef char TThostFtdcSystemParamIDType
    ctypedef char TThostFtdcTradeParamIDType
    ctypedef char TThostFtdcSettlementParamValueType[256]
    ctypedef char TThostFtdcCounterIDType[33]
    ctypedef char TThostFtdcInvestorGroupNameType[41]
    ctypedef char TThostFtdcBrandCodeType[257]
    ctypedef char TThostFtdcWarehouseType[257]
    ctypedef char TThostFtdcProductDateType[41]
    ctypedef char TThostFtdcGradeType[41]
    ctypedef char TThostFtdcClassifyType[41]
    ctypedef char TThostFtdcPositionType[41]
    ctypedef char TThostFtdcYieldlyType[41]
    ctypedef char TThostFtdcWeightType[41]
    ctypedef int TThostFtdcSubEntryFundNoType
    ctypedef char TThostFtdcFileIDType
    ctypedef char TThostFtdcFileNameType[257]
    ctypedef char TThostFtdcFileTypeType
    ctypedef char TThostFtdcFileFormatType
    ctypedef char TThostFtdcFileUploadStatusType
    ctypedef char TThostFtdcTransferDirectionType
    ctypedef char TThostFtdcUploadModeType[21]
    ctypedef char TThostFtdcAccountIDType[13]
    ctypedef char TThostFtdcBankFlagType[4]
    ctypedef char TThostFtdcBankAccountType[41]
    ctypedef char TThostFtdcOpenNameType[61]
    ctypedef char TThostFtdcOpenBankType[101]
    ctypedef char TThostFtdcBankNameType[101]
    ctypedef char TThostFtdcPublishPathType[257]
    ctypedef char TThostFtdcOperatorIDType[65]
    ctypedef int TThostFtdcMonthCountType
    ctypedef char TThostFtdcAdvanceMonthArrayType[13]
    ctypedef char TThostFtdcDateExprType[1025]
    ctypedef char TThostFtdcInstrumentIDExprType[41]
    ctypedef char TThostFtdcInstrumentNameExprType[41]
    ctypedef char TThostFtdcSpecialCreateRuleType
    ctypedef char TThostFtdcBasisPriceTypeType
    ctypedef char TThostFtdcProductLifePhaseType
    ctypedef char TThostFtdcDeliveryModeType
    ctypedef char TThostFtdcLogLevelType[33]
    ctypedef char TThostFtdcProcessNameType[257]
    ctypedef char TThostFtdcOperationMemoType[1025]
    ctypedef char TThostFtdcFundIOTypeType
    ctypedef char TThostFtdcFundTypeType
    ctypedef char TThostFtdcFundDirectionType
    ctypedef char TThostFtdcFundStatusType
    ctypedef char TThostFtdcBillNoType[15]
    ctypedef char TThostFtdcBillNameType[33]
    ctypedef char TThostFtdcPublishStatusType
    ctypedef char TThostFtdcEnumValueIDType[65]
    ctypedef char TThostFtdcEnumValueTypeType[33]
    ctypedef char TThostFtdcEnumValueLabelType[65]
    ctypedef char TThostFtdcEnumValueResultType[33]
    ctypedef char TThostFtdcSystemStatusType
    ctypedef char TThostFtdcSettlementStatusType
    ctypedef char TThostFtdcRangeIntTypeType[33]
    ctypedef char TThostFtdcRangeIntFromType[33]
    ctypedef char TThostFtdcRangeIntToType[33]
    ctypedef char TThostFtdcFunctionIDType[25]
    ctypedef char TThostFtdcFunctionValueCodeType[257]
    ctypedef char TThostFtdcFunctionNameType[65]
    ctypedef char TThostFtdcRoleIDType[11]
    ctypedef char TThostFtdcRoleNameType[41]
    ctypedef char TThostFtdcDescriptionType[401]
    ctypedef char TThostFtdcCombineIDType[25]
    ctypedef char TThostFtdcCombineTypeType[25]
    ctypedef char TThostFtdcInvestorTypeType
    ctypedef char TThostFtdcBrokerTypeType
    ctypedef char TThostFtdcRiskLevelType
    ctypedef char TThostFtdcFeeAcceptStyleType
    ctypedef char TThostFtdcPasswordTypeType
    ctypedef char TThostFtdcAlgorithmType
    ctypedef char TThostFtdcIncludeCloseProfitType
    ctypedef char TThostFtdcAllWithoutTradeType
    ctypedef char TThostFtdcCommentType[31]
    ctypedef char TThostFtdcVersionType[4]
    ctypedef char TThostFtdcTradeCodeType[7]
    ctypedef char TThostFtdcTradeDateType[9]
    ctypedef char TThostFtdcTradeTimeType[9]
    ctypedef char TThostFtdcTradeSerialType[9]
    ctypedef int TThostFtdcTradeSerialNoType
    ctypedef char TThostFtdcFutureIDType[11]
    ctypedef char TThostFtdcBankIDType[4]
    ctypedef char TThostFtdcBankBrchIDType[5]
    ctypedef char TThostFtdcBankBranchIDType[11]
    ctypedef char TThostFtdcOperNoType[17]
    ctypedef char TThostFtdcDeviceIDType[3]
    ctypedef char TThostFtdcRecordNumType[7]
    ctypedef char TThostFtdcFutureAccountType[22]
    ctypedef char TThostFtdcFuturePwdFlagType
    ctypedef char TThostFtdcTransferTypeType
    ctypedef char TThostFtdcFutureAccPwdType[17]
    ctypedef char TThostFtdcCurrencyCodeType[4]
    ctypedef char TThostFtdcRetCodeType[5]
    ctypedef char TThostFtdcRetInfoType[129]
    ctypedef char TThostFtdcTradeAmtType[20]
    ctypedef char TThostFtdcUseAmtType[20]
    ctypedef char TThostFtdcFetchAmtType[20]
    ctypedef char TThostFtdcTransferValidFlagType
    ctypedef char TThostFtdcCertCodeType[21]
    ctypedef char TThostFtdcReasonType
    ctypedef char TThostFtdcFundProjectIDType[5]
    ctypedef char TThostFtdcSexType
    ctypedef char TThostFtdcProfessionType[101]
    ctypedef char TThostFtdcNationalType[31]
    ctypedef char TThostFtdcProvinceType[51]
    ctypedef char TThostFtdcRegionType[16]
    ctypedef char TThostFtdcCountryType[16]
    ctypedef char TThostFtdcLicenseNOType[33]
    ctypedef char TThostFtdcCompanyTypeType[16]
    ctypedef char TThostFtdcBusinessScopeType[1001]
    ctypedef char TThostFtdcCapitalCurrencyType[4]
    ctypedef char TThostFtdcUserTypeType
    ctypedef char TThostFtdcBranchIDType[9]
    ctypedef char TThostFtdcRateTypeType
    ctypedef char TThostFtdcNoteTypeType
    ctypedef char TThostFtdcSettlementStyleType
    ctypedef char TThostFtdcBrokerDNSType[256]
    ctypedef char TThostFtdcSentenceType[501]
    ctypedef char TThostFtdcSettlementBillTypeType
    ctypedef char TThostFtdcUserRightTypeType
    ctypedef char TThostFtdcMarginPriceTypeType
    ctypedef char TThostFtdcBillGenStatusType
    ctypedef char TThostFtdcAlgoTypeType
    ctypedef char TThostFtdcHandlePositionAlgoIDType
    ctypedef char TThostFtdcFindMarginRateAlgoIDType
    ctypedef char TThostFtdcHandleTradingAccountAlgoIDType
    ctypedef char TThostFtdcPersonTypeType
    ctypedef char TThostFtdcQueryInvestorRangeType
    ctypedef char TThostFtdcInvestorRiskStatusType
    ctypedef int TThostFtdcLegIDType
    ctypedef int TThostFtdcLegMultipleType
    ctypedef int TThostFtdcImplyLevelType
    ctypedef char TThostFtdcClearAccountType[33]
    ctypedef char TThostFtdcOrganNOType[6]
    ctypedef char TThostFtdcClearbarchIDType[6]
    ctypedef char TThostFtdcUserEventTypeType
    ctypedef char TThostFtdcUserEventInfoType[1025]
    ctypedef char TThostFtdcCloseStyleType
    ctypedef char TThostFtdcStatModeType
    ctypedef char TThostFtdcParkedOrderStatusType
    ctypedef char TThostFtdcParkedOrderIDType[13]
    ctypedef char TThostFtdcParkedOrderActionIDType[13]
    ctypedef char TThostFtdcVirDealStatusType
    ctypedef char TThostFtdcOrgSystemIDType
    ctypedef char TThostFtdcVirTradeStatusType
    ctypedef char TThostFtdcVirBankAccTypeType
    ctypedef char TThostFtdcVirementStatusType
    ctypedef char TThostFtdcVirementAvailAbilityType
    ctypedef char TThostFtdcVirementTradeCodeType
    ctypedef char TThostFtdcPhotoTypeNameType[41]
    ctypedef char TThostFtdcPhotoTypeIDType[5]
    ctypedef char TThostFtdcPhotoNameType[161]
    ctypedef int TThostFtdcTopicIDType
    ctypedef char TThostFtdcReportTypeIDType[3]
    ctypedef char TThostFtdcCharacterIDType[5]
    ctypedef char TThostFtdcAMLParamIDType[21]
    ctypedef char TThostFtdcAMLInvestorTypeType[3]
    ctypedef char TThostFtdcAMLIdCardTypeType[3]
    ctypedef char TThostFtdcAMLTradeDirectType[3]
    ctypedef char TThostFtdcAMLTradeModelType[3]
    ctypedef double TThostFtdcAMLOpParamValueType
    ctypedef char TThostFtdcAMLCustomerCardTypeType[81]
    ctypedef char TThostFtdcAMLInstitutionNameType[65]
    ctypedef char TThostFtdcAMLDistrictIDType[7]
    ctypedef char TThostFtdcAMLRelationShipType[3]
    ctypedef char TThostFtdcAMLInstitutionTypeType[3]
    ctypedef char TThostFtdcAMLInstitutionIDType[13]
    ctypedef char TThostFtdcAMLAccountTypeType[5]
    ctypedef char TThostFtdcAMLTradingTypeType[7]
    ctypedef char TThostFtdcAMLTransactClassType[7]
    ctypedef char TThostFtdcAMLCapitalIOType[3]
    ctypedef char TThostFtdcAMLSiteType[10]
    ctypedef char TThostFtdcAMLCapitalPurposeType[129]
    ctypedef char TThostFtdcAMLReportTypeType[2]
    ctypedef char TThostFtdcAMLSerialNoType[5]
    ctypedef char TThostFtdcAMLStatusType[2]
    ctypedef char TThostFtdcAMLGenStatusType
    ctypedef char TThostFtdcAMLSeqCodeType[65]
    ctypedef char TThostFtdcAMLFileNameType[257]
    ctypedef double TThostFtdcAMLMoneyType
    ctypedef int TThostFtdcAMLFileAmountType
    ctypedef char TThostFtdcCFMMCKeyType[21]
    ctypedef char TThostFtdcCFMMCTokenType[21]
    ctypedef char TThostFtdcCFMMCKeyKindType
    ctypedef char TThostFtdcAMLReportNameType[81]
    ctypedef char TThostFtdcIndividualNameType[51]
    ctypedef char TThostFtdcCurrencyIDType[4]
    ctypedef char TThostFtdcCustNumberType[36]
    ctypedef char TThostFtdcOrganCodeType[36]
    ctypedef char TThostFtdcOrganNameType[71]
    ctypedef char TThostFtdcSuperOrganCodeType[12]
    ctypedef char TThostFtdcSubBranchIDType[31]
    ctypedef char TThostFtdcSubBranchNameType[71]
    ctypedef char TThostFtdcBranchNetCodeType[31]
    ctypedef char TThostFtdcBranchNetNameType[71]
    ctypedef char TThostFtdcOrganFlagType[2]
    ctypedef char TThostFtdcBankCodingForFutureType[33]
    ctypedef char TThostFtdcBankReturnCodeType[7]
    ctypedef char TThostFtdcPlateReturnCodeType[5]
    ctypedef char TThostFtdcBankSubBranchIDType[31]
    ctypedef char TThostFtdcFutureBranchIDType[31]
    ctypedef char TThostFtdcReturnCodeType[7]
    ctypedef char TThostFtdcOperatorCodeType[17]
    ctypedef char TThostFtdcClearDepIDType[6]
    ctypedef char TThostFtdcClearBrchIDType[6]
    ctypedef char TThostFtdcClearNameType[71]
    ctypedef char TThostFtdcBankAccountNameType[71]
    ctypedef char TThostFtdcInvDepIDType[6]
    ctypedef char TThostFtdcInvBrchIDType[6]
    ctypedef char TThostFtdcMessageFormatVersionType[36]
    ctypedef char TThostFtdcDigestType[36]
    ctypedef char TThostFtdcAuthenticDataType[129]
    ctypedef char TThostFtdcPasswordKeyType[129]
    ctypedef char TThostFtdcFutureAccountNameType[129]
    ctypedef char TThostFtdcMobilePhoneType[21]
    ctypedef char TThostFtdcFutureMainKeyType[129]
    ctypedef char TThostFtdcFutureWorkKeyType[129]
    ctypedef char TThostFtdcFutureTransKeyType[129]
    ctypedef char TThostFtdcBankMainKeyType[129]
    ctypedef char TThostFtdcBankWorkKeyType[129]
    ctypedef char TThostFtdcBankTransKeyType[129]
    ctypedef char TThostFtdcBankServerDescriptionType[129]
    ctypedef char TThostFtdcAddInfoType[129]
    ctypedef char TThostFtdcDescrInfoForReturnCodeType[129]
    ctypedef char TThostFtdcCountryCodeType[21]
    ctypedef int TThostFtdcSerialType
    ctypedef int TThostFtdcPlateSerialType
    ctypedef char TThostFtdcBankSerialType[13]
    ctypedef int TThostFtdcCorrectSerialType
    ctypedef int TThostFtdcFutureSerialType
    ctypedef int TThostFtdcApplicationIDType
    ctypedef int TThostFtdcBankProxyIDType
    ctypedef int TThostFtdcFBTCoreIDType
    ctypedef int TThostFtdcServerPortType
    ctypedef int TThostFtdcRepealedTimesType
    ctypedef int TThostFtdcRepealTimeIntervalType
    ctypedef int TThostFtdcTotalTimesType
    ctypedef int TThostFtdcFBTRequestIDType
    ctypedef int TThostFtdcTIDType
    ctypedef double TThostFtdcTradeAmountType
    ctypedef double TThostFtdcCustFeeType
    ctypedef double TThostFtdcFutureFeeType
    ctypedef double TThostFtdcSingleMaxAmtType
    ctypedef double TThostFtdcSingleMinAmtType
    ctypedef double TThostFtdcTotalAmtType
    ctypedef char TThostFtdcCertificationTypeType
    ctypedef char TThostFtdcFileBusinessCodeType
    ctypedef char TThostFtdcCashExchangeCodeType
    ctypedef char TThostFtdcYesNoIndicatorType
    ctypedef char TThostFtdcBanlanceTypeType
    ctypedef char TThostFtdcGenderType
    ctypedef char TThostFtdcFeePayFlagType
    ctypedef char TThostFtdcPassWordKeyTypeType
    ctypedef char TThostFtdcFBTPassWordTypeType
    ctypedef char TThostFtdcFBTEncryModeType
    ctypedef char TThostFtdcBankRepealFlagType
    ctypedef char TThostFtdcBrokerRepealFlagType
    ctypedef char TThostFtdcInstitutionTypeType
    ctypedef char TThostFtdcLastFragmentType
    ctypedef char TThostFtdcBankAccStatusType
    ctypedef char TThostFtdcMoneyAccountStatusType
    ctypedef char TThostFtdcManageStatusType
    ctypedef char TThostFtdcSystemTypeType
    ctypedef char TThostFtdcTxnEndFlagType
    ctypedef char TThostFtdcProcessStatusType
    ctypedef char TThostFtdcCustTypeType
    ctypedef char TThostFtdcFBTTransferDirectionType
    ctypedef char TThostFtdcOpenOrDestroyType
    ctypedef char TThostFtdcAvailabilityFlagType
    ctypedef char TThostFtdcOrganTypeType
    ctypedef char TThostFtdcOrganLevelType
    ctypedef char TThostFtdcProtocalIDType
    ctypedef char TThostFtdcConnectModeType
    ctypedef char TThostFtdcSyncModeType
    ctypedef char TThostFtdcBankAccTypeType
    ctypedef char TThostFtdcFutureAccTypeType
    ctypedef char TThostFtdcOrganStatusType
    ctypedef char TThostFtdcCCBFeeModeType
    ctypedef char TThostFtdcCommApiTypeType
    ctypedef int TThostFtdcServiceIDType
    ctypedef int TThostFtdcServiceLineNoType
    ctypedef char TThostFtdcServiceNameType[61]
    ctypedef char TThostFtdcLinkStatusType
    ctypedef int TThostFtdcCommApiPointerType
    ctypedef char TThostFtdcPwdFlagType
    ctypedef char TThostFtdcSecuAccTypeType
    ctypedef char TThostFtdcTransferStatusType
    ctypedef char TThostFtdcSponsorTypeType
    ctypedef char TThostFtdcReqRspTypeType
    ctypedef char TThostFtdcFBTUserEventTypeType
    ctypedef char TThostFtdcBankIDByBankType[21]
    ctypedef char TThostFtdcBankOperNoType[4]
    ctypedef char TThostFtdcBankCustNoType[21]
    ctypedef int TThostFtdcDBOPSeqNoType
    ctypedef char TThostFtdcTableNameType[61]
    ctypedef char TThostFtdcPKNameType[201]
    ctypedef char TThostFtdcPKValueType[501]
    ctypedef char TThostFtdcDBOperationType
    ctypedef char TThostFtdcSyncFlagType
    ctypedef char TThostFtdcTargetIDType[4]
    ctypedef char TThostFtdcSyncTypeType
    ctypedef char TThostFtdcFBETimeType[7]
    ctypedef char TThostFtdcFBEBankNoType[13]
    ctypedef char TThostFtdcFBECertNoType[13]
    ctypedef char TThostFtdcExDirectionType
    ctypedef char TThostFtdcFBEBankAccountType[33]
    ctypedef char TThostFtdcFBEBankAccountNameType[61]
    ctypedef double TThostFtdcFBEAmtType
    ctypedef char TThostFtdcFBEBusinessTypeType[3]
    ctypedef char TThostFtdcFBEPostScriptType[61]
    ctypedef char TThostFtdcFBERemarkType[71]
    ctypedef double TThostFtdcExRateType
    ctypedef char TThostFtdcFBEResultFlagType
    ctypedef char TThostFtdcFBERtnMsgType[61]
    ctypedef char TThostFtdcFBEExtendMsgType[61]
    ctypedef char TThostFtdcFBEBusinessSerialType[31]
    ctypedef char TThostFtdcFBESystemSerialType[21]
    ctypedef int TThostFtdcFBETotalExCntType
    ctypedef char TThostFtdcFBEExchStatusType
    ctypedef char TThostFtdcFBEFileFlagType
    ctypedef char TThostFtdcFBEAlreadyTradeType
    ctypedef char TThostFtdcFBEOpenBankType[61]
    ctypedef char TThostFtdcFBEUserEventTypeType
    ctypedef char TThostFtdcFBEFileNameType[21]
    ctypedef char TThostFtdcFBEBatchSerialType[21]
    ctypedef char TThostFtdcFBEReqFlagType
    ctypedef char TThostFtdcNotifyClassType
    ctypedef char TThostFtdcRiskNofityInfoType[257]
    ctypedef char TThostFtdcForceCloseSceneIdType[24]
    ctypedef char TThostFtdcForceCloseTypeType
    ctypedef char TThostFtdcInstrumentIDsType[101]
    ctypedef char TThostFtdcRiskNotifyMethodType
    ctypedef char TThostFtdcRiskNotifyStatusType
    ctypedef char TThostFtdcRiskUserEventType
    ctypedef int TThostFtdcParamIDType
    ctypedef char TThostFtdcParamNameType[41]
    ctypedef char TThostFtdcParamValueType[41]
    ctypedef char TThostFtdcConditionalOrderSortTypeType
    ctypedef char TThostFtdcSendTypeType
    ctypedef char TThostFtdcClientIDStatusType
    ctypedef char TThostFtdcIndustryIDType[17]
    ctypedef char TThostFtdcQuestionIDType[5]
    ctypedef char TThostFtdcQuestionContentType[41]
    ctypedef char TThostFtdcOptionIDType[13]
    ctypedef char TThostFtdcOptionContentType[61]
    ctypedef char TThostFtdcQuestionTypeType
    ctypedef char TThostFtdcProcessIDType[33]
    ctypedef int TThostFtdcSeqNoType
    ctypedef char TThostFtdcUOAProcessStatusType[3]
    ctypedef char TThostFtdcProcessTypeType[3]
    ctypedef char TThostFtdcBusinessTypeType
    ctypedef char TThostFtdcCfmmcReturnCodeType
    ctypedef int TThostFtdcExReturnCodeType
    ctypedef char TThostFtdcClientTypeType
    ctypedef char TThostFtdcExchangeIDTypeType
    ctypedef char TThostFtdcExClientIDTypeType
    ctypedef char TThostFtdcClientClassifyType[11]
    ctypedef char TThostFtdcUOAOrganTypeType[11]
    ctypedef char TThostFtdcUOACountryCodeType[11]
    ctypedef char TThostFtdcAreaCodeType[11]
    ctypedef char TThostFtdcFuturesIDType[21]
    ctypedef char TThostFtdcCffmcDateType[11]
    ctypedef char TThostFtdcCffmcTimeType[11]
    ctypedef char TThostFtdcNocIDType[21]
    ctypedef char TThostFtdcUpdateFlagType
    ctypedef char TThostFtdcApplyOperateIDType
    ctypedef char TThostFtdcApplyStatusIDType
    ctypedef char TThostFtdcSendMethodType
    ctypedef char TThostFtdcEventTypeType[33]
    ctypedef char TThostFtdcEventModeType
    ctypedef char TThostFtdcUOAAutoSendType
    ctypedef int TThostFtdcQueryDepthType
    ctypedef int TThostFtdcDataCenterIDType
    ctypedef char TThostFtdcFlowIDType
    ctypedef char TThostFtdcCheckLevelType
    ctypedef int TThostFtdcCheckNoType
    ctypedef char TThostFtdcCheckStatusType
    ctypedef char TThostFtdcUsedStatusType
    ctypedef char TThostFtdcRateTemplateNameType[61]
    ctypedef char TThostFtdcPropertyStringType[2049]
    ctypedef char TThostFtdcBankAcountOriginType
    ctypedef char TThostFtdcMonthBillTradeSumType
    ctypedef char TThostFtdcFBTTradeCodeEnumType
    ctypedef char TThostFtdcRateTemplateIDType[9]
    ctypedef char TThostFtdcRiskRateType[21]
    ctypedef int TThostFtdcTimestampType
    ctypedef char TThostFtdcInvestorIDRuleNameType[61]
    ctypedef char TThostFtdcInvestorIDRuleExprType[513]
    ctypedef int TThostFtdcLastDriftType
    ctypedef int TThostFtdcLastSuccessType
    ctypedef char TThostFtdcAuthKeyType[41]
    ctypedef char TThostFtdcSerialNumberType[17]
    ctypedef char TThostFtdcOTPTypeType
    ctypedef char TThostFtdcOTPVendorsIDType[2]
    ctypedef char TThostFtdcOTPVendorsNameType[61]
    ctypedef char TThostFtdcOTPStatusType
    ctypedef char TThostFtdcBrokerUserTypeType
    ctypedef char TThostFtdcFutureTypeType
    ctypedef char TThostFtdcFundEventTypeType
    ctypedef char TThostFtdcAccountSourceTypeType
    ctypedef char TThostFtdcCodeSourceTypeType
    ctypedef char TThostFtdcUserRangeType
    ctypedef char TThostFtdcTimeSpanType[9]
    ctypedef char TThostFtdcImportSequenceIDType[17]
    ctypedef char TThostFtdcByGroupType
    ctypedef char TThostFtdcTradeSumStatModeType
    ctypedef int TThostFtdcComTypeType
    ctypedef char TThostFtdcUserProductIDType[33]
    ctypedef char TThostFtdcUserProductNameType[65]
    ctypedef char TThostFtdcUserProductMemoType[129]
    ctypedef char TThostFtdcCSRCCancelFlagType[2]
    ctypedef char TThostFtdcCSRCDateType[11]
    ctypedef char TThostFtdcCSRCInvestorNameType[201]
    ctypedef char TThostFtdcCSRCOpenInvestorNameType[101]
    ctypedef char TThostFtdcCSRCInvestorIDType[13]
    ctypedef char TThostFtdcCSRCIdentifiedCardNoType[51]
    ctypedef char TThostFtdcCSRCClientIDType[11]
    ctypedef char TThostFtdcCSRCBankFlagType[3]
    ctypedef char TThostFtdcCSRCBankAccountType[23]
    ctypedef char TThostFtdcCSRCOpenNameType[401]
    ctypedef char TThostFtdcCSRCMemoType[101]
    ctypedef char TThostFtdcCSRCTimeType[11]
    ctypedef char TThostFtdcCSRCTradeIDType[21]
    ctypedef char TThostFtdcCSRCExchangeInstIDType[31]
    ctypedef char TThostFtdcCSRCMortgageNameType[7]
    ctypedef char TThostFtdcCSRCReasonType[3]
    ctypedef char TThostFtdcIsSettlementType[2]
    ctypedef double TThostFtdcCSRCMoneyType
    ctypedef double TThostFtdcCSRCPriceType
    ctypedef char TThostFtdcCSRCOptionsTypeType[2]
    ctypedef double TThostFtdcCSRCStrikePriceType
    ctypedef char TThostFtdcCSRCTargetProductIDType[3]
    ctypedef char TThostFtdcCSRCTargetInstrIDType[31]
    ctypedef char TThostFtdcCommModelNameType[161]
    ctypedef char TThostFtdcCommModelMemoType[1025]
    ctypedef char TThostFtdcExprSetModeType
    ctypedef char TThostFtdcRateInvestorRangeType
    ctypedef char TThostFtdcAgentBrokerIDType[13]
    ctypedef int TThostFtdcDRIdentityIDType
    ctypedef char TThostFtdcDRIdentityNameType[65]
    ctypedef char TThostFtdcDBLinkIDType[31]
    ctypedef char TThostFtdcSyncDataStatusType
    ctypedef char TThostFtdcTradeSourceType
    ctypedef char TThostFtdcFlexStatModeType
    ctypedef char TThostFtdcByInvestorRangeType
    ctypedef char TThostFtdcSRiskRateType[21]
    ctypedef int TThostFtdcSequenceNo12Type
    ctypedef char TThostFtdcPropertyInvestorRangeType
    ctypedef char TThostFtdcFileStatusType
    ctypedef char TThostFtdcFileGenStyleType
    ctypedef char TThostFtdcSysOperModeType
    ctypedef char TThostFtdcSysOperTypeType
    ctypedef char TThostFtdcCSRCDataQueyTypeType
    ctypedef char TThostFtdcFreezeStatusType
    ctypedef char TThostFtdcStandardStatusType
    ctypedef char TThostFtdcCSRCFreezeStatusType[2]
    ctypedef char TThostFtdcRightParamTypeType
    ctypedef char TThostFtdcRightTemplateIDType[9]
    ctypedef char TThostFtdcRightTemplateNameType[61]
    ctypedef char TThostFtdcDataStatusType
    ctypedef char TThostFtdcAMLCheckStatusType
    ctypedef char TThostFtdcAmlDateTypeType
    ctypedef char TThostFtdcAmlCheckLevelType
    ctypedef char TThostFtdcAmlCheckFlowType[2]
    ctypedef char TThostFtdcDataTypeType[129]
    ctypedef char TThostFtdcExportFileTypeType
    ctypedef char TThostFtdcSettleManagerTypeType
    ctypedef char TThostFtdcSettleManagerIDType[33]
    ctypedef char TThostFtdcSettleManagerNameType[129]
    ctypedef char TThostFtdcSettleManagerLevelType
    ctypedef char TThostFtdcSettleManagerGroupType
    ctypedef char TThostFtdcCheckResultMemoType[1025]
    ctypedef char TThostFtdcFunctionUrlType[1025]
    ctypedef char TThostFtdcAuthInfoType[129]
    ctypedef char TThostFtdcAuthCodeType[17]
    ctypedef char TThostFtdcLimitUseTypeType
    ctypedef char TThostFtdcDataResourceType
    ctypedef char TThostFtdcMarginTypeType
    ctypedef char TThostFtdcActiveTypeType
    ctypedef char TThostFtdcMarginRateTypeType
    ctypedef char TThostFtdcBackUpStatusType
    ctypedef char TThostFtdcInitSettlementType
    ctypedef char TThostFtdcReportStatusType
    ctypedef char TThostFtdcSaveStatusType
    ctypedef char TThostFtdcSettArchiveStatusType
    ctypedef char TThostFtdcCTPTypeType
    ctypedef char TThostFtdcToolIDType[9]
    ctypedef char TThostFtdcToolNameType[81]
    ctypedef char TThostFtdcCloseDealTypeType
    ctypedef char TThostFtdcMortgageFundUseRangeType
    ctypedef double TThostFtdcCurrencyUnitType
    ctypedef double TThostFtdcExchangeRateType
    ctypedef char TThostFtdcSpecProductTypeType
    ctypedef char TThostFtdcFundMortgageTypeType
    ctypedef char TThostFtdcAccountSettlementParamIDType
    ctypedef char TThostFtdcCurrencyNameType[31]
    ctypedef char TThostFtdcCurrencySignType[4]
    ctypedef char TThostFtdcFundMortDirectionType
    ctypedef char TThostFtdcBusinessClassType
    ctypedef char TThostFtdcSwapSourceTypeType
    ctypedef char TThostFtdcCurrExDirectionType
    ctypedef char TThostFtdcCurrencySwapStatusType
    ctypedef char TThostFtdcCurrExchCertNoType[13]
    ctypedef char TThostFtdcBatchSerialNoType[21]
    ctypedef char TThostFtdcReqFlagType
    ctypedef char TThostFtdcResFlagType
    ctypedef char TThostFtdcPageControlType[2]
    ctypedef int TThostFtdcRecordCountType
    ctypedef char TThostFtdcCurrencySwapMemoType[101]
    ctypedef char TThostFtdcExStatusType
    ctypedef char TThostFtdcClientRegionType
    ctypedef char TThostFtdcWorkPlaceType[101]
    ctypedef char TThostFtdcBusinessPeriodType[21]
    ctypedef char TThostFtdcWebSiteType[101]
    ctypedef char TThostFtdcUOAIdCardTypeType[3]
    ctypedef char TThostFtdcClientModeType[3]
    ctypedef char TThostFtdcInvestorFullNameType[101]
    ctypedef char TThostFtdcUOABrokerIDType[11]
    ctypedef char TThostFtdcUOAZipCodeType[11]
    ctypedef char TThostFtdcUOAEMailType[101]
    ctypedef char TThostFtdcOldCityType[41]
    ctypedef char TThostFtdcCorporateIdentifiedCardNoType[101]
    ctypedef char TThostFtdcHasBoardType
    ctypedef char TThostFtdcStartModeType
    ctypedef char TThostFtdcTemplateTypeType
    ctypedef char TThostFtdcLoginModeType
    ctypedef char TThostFtdcPromptTypeType
    ctypedef char TThostFtdcLedgerManageIDType[51]
    ctypedef char TThostFtdcInvestVarietyType[101]
    ctypedef char TThostFtdcBankAccountTypeType[2]
    ctypedef char TThostFtdcLedgerManageBankType[101]
    ctypedef char TThostFtdcCffexDepartmentNameType[101]
    ctypedef char TThostFtdcCffexDepartmentCodeType[9]
    ctypedef char TThostFtdcHasTrusteeType
    ctypedef char TThostFtdcCSRCMemo1Type[41]
    ctypedef char TThostFtdcAssetmgrCFullNameType[101]
    ctypedef char TThostFtdcAssetmgrApprovalNOType[51]
    ctypedef char TThostFtdcAssetmgrMgrNameType[401]
    ctypedef char TThostFtdcAmTypeType
    ctypedef char TThostFtdcCSRCAmTypeType[5]
    ctypedef char TThostFtdcCSRCFundIOTypeType
    ctypedef char TThostFtdcCusAccountTypeType
    ctypedef char TThostFtdcCSRCNationalType[4]
    ctypedef char TThostFtdcCSRCSecAgentIDType[11]
    ctypedef char TThostFtdcLanguageTypeType
    ctypedef char TThostFtdcAmAccountType[23]
    ctypedef char TThostFtdcAssetmgrClientTypeType
    ctypedef char TThostFtdcAssetmgrTypeType
    ctypedef char TThostFtdcUOMType[11]
    ctypedef char TThostFtdcSHFEInstLifePhaseType[3]
    ctypedef char TThostFtdcSHFEProductClassType[11]
    ctypedef char TThostFtdcPriceDecimalType[2]
    ctypedef char TThostFtdcInTheMoneyFlagType[2]
    ctypedef char TThostFtdcCheckInstrTypeType
    ctypedef char TThostFtdcDeliveryTypeType
    ctypedef double TThostFtdcBigMoneyType
    ctypedef char TThostFtdcMaxMarginSideAlgorithmType
    ctypedef char TThostFtdcDAClientTypeType
    ctypedef char TThostFtdcCombinInstrIDType[61]
    ctypedef char TThostFtdcCombinSettlePriceType[61]
    ctypedef int TThostFtdcDCEPriorityType
    ctypedef int TThostFtdcTradeGroupIDType
    ctypedef int TThostFtdcIsCheckPrepaType
    ctypedef char TThostFtdcUOAAssetmgrTypeType
    ctypedef char TThostFtdcDirectionEnType
    ctypedef char TThostFtdcOffsetFlagEnType
    ctypedef char TThostFtdcHedgeFlagEnType
    ctypedef char TThostFtdcFundIOTypeEnType
    ctypedef char TThostFtdcFundTypeEnType
    ctypedef char TThostFtdcFundDirectionEnType
    ctypedef char TThostFtdcFundMortDirectionEnType
    ctypedef char TThostFtdcSwapBusinessTypeType[3]
    ctypedef char TThostFtdcOptionsTypeType
    ctypedef char TThostFtdcStrikeModeType
    ctypedef char TThostFtdcStrikeTypeType
    ctypedef char TThostFtdcApplyTypeType
    ctypedef char TThostFtdcGiveUpDataSourceType
    ctypedef char TThostFtdcExecOrderSysIDType[21]
    ctypedef char TThostFtdcExecResultType
    ctypedef int TThostFtdcStrikeSequenceType
    ctypedef char TThostFtdcStrikeTimeType[13]
    ctypedef char TThostFtdcCombinationTypeType
    ctypedef char TThostFtdcOptionRoyaltyPriceTypeType
    ctypedef char TThostFtdcBalanceAlgorithmType
    ctypedef char TThostFtdcActionTypeType
    ctypedef char TThostFtdcForQuoteStatusType
    ctypedef char TThostFtdcValueMethodType
    ctypedef char TThostFtdcExecOrderPositionFlagType
    ctypedef char TThostFtdcExecOrderCloseFlagType
    ctypedef char TThostFtdcProductTypeType
    ctypedef char TThostFtdcCZCEUploadFileNameType
    ctypedef char TThostFtdcDCEUploadFileNameType
    ctypedef char TThostFtdcSHFEUploadFileNameType
    ctypedef char TThostFtdcCFFEXUploadFileNameType
    ctypedef char TThostFtdcCombDirectionType
    ctypedef char TThostFtdcStrikeOffsetTypeType
    ctypedef char TThostFtdcReserveOpenAccStasType
    ctypedef char TThostFtdcLoginRemarkType[36]
    ctypedef char TThostFtdcInvestUnitIDType[17]
    ctypedef int TThostFtdcBulletinIDType
    ctypedef char TThostFtdcNewsTypeType[3]
    ctypedef char TThostFtdcNewsUrgencyType
    ctypedef char TThostFtdcAbstractType[81]
    ctypedef char TThostFtdcComeFromType[21]
    ctypedef char TThostFtdcURLLinkType[201]
    ctypedef char TThostFtdcLongIndividualNameType[161]
    ctypedef char TThostFtdcLongFBEBankAccountNameType[161]
    ctypedef char TThostFtdcDateTimeType[17]
    ctypedef char TThostFtdcWeakPasswordSourceType
    ctypedef char TThostFtdcRandomStringType[17]
    ctypedef char TThostFtdcOptSelfCloseFlagType
    ctypedef char TThostFtdcBizTypeType
