select distinct hi my name is nygal
    TO_CHAR((ADD_MONTHS(GJH.DEFAULT_EFFECTIVE_DATE,6)),'YYYY') "FISCAL_YEAR",
    GP.PERIOD_NUM "ACCOUNTING_PERIOD",
GP.PERIOD_NAME "PERIOD_NAME",
	CASE WHEN 
    XAL.ACCOUNTING_DATE IS NULL
    THEN TO_CHAR(GJH.POSTED_DATE, 'YYYY-MM-DD')
    ELSE TO_CHAR(XAL.ACCOUNTING_DATE, 'YYYY-MM-DD') 
    END AS "ACCOUNTING_DATE",
    GLCC.SEGMENT3 "ACCOUNT",
    --GLCC.SEGMENT1 "ACCOUNT_SOURCE", --JUST FOR REFERENCE 
    lpad(API.DOC_SEQUENCE_VALUE,8, '0') "VOUCHER_ID",
    --GL SL Link ID is what links the general ledger to subledger XAL. If this is null, you can't reach the subledger so we pull the general journal debit and credit. Have to still use XAL Accounted because you will see repeated amounts of general journals for each journal that has a subledger. if link id is null, then there isn't a subledger.
    
    CASE
    WHEN 
    gir.GL_SL_LINK_ID IS NULL
    THEN (NVL(GJL.ACCOUNTED_DR, 0)) - (NVL(GJL.ACCOUNTED_CR, 0))


    ELSE (NVL(XAL.ACCOUNTED_DR, 0)) - (NVL(XAL.ACCOUNTED_CR, 0)) END AS "MONETARY_AMOUNT",
    GLB.NAME "DESCRIPTION",
    --GJL.ATTRIBUTE2 "JOURNAL_ID", --WHAT DO WE NEED FOR THIS? SEE THE SF/AP LEAD DESIGNATION
    SUBSTR(GJC.JE_CATEGORY_KEY, 1, 3)||GJH.POSTING_ACCT_SEQ_VALUE "JOURNAL_ID",
    GJC.JE_CATEGORY_KEY "SOURCE", --TAKING JOURNAL CATEGORY NAME, IS THIS WHAT WE WANT?
    CASE WHEN IPA.DOCUMENT_SEQUENCE_VALUE IS NULL THEN '' ELSE 'VZ'||lpad(ipa.DOCUMENT_SEQUENCE_VALUE,6, '0') END AS "PMT_ID",
    -------------------------------------------------------------
    CASE WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '1000' and '4525' then '40' 

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '5001' and '5905' then '43' 

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '4600' and '4615' then '46'

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '4700' and '4725' then '47' 

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '4800' and '4890' then '48' 

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '4900' and '4990' then '49' 
    else 'XX' end as "FUND",
    ---------------------------------------------------------------------
    CASE
        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ01'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '01'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ02'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '02'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ03'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '03'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ04'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '04'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ05'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '05'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ06'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '06'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ07'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '07'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ08'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '08'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ09'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '09'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ10'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '10'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ11'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '11'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ12'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '12'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ13'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '13'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ14'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '14'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8337'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8337'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8343'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8343'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8475'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8475'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8478'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8478'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8481'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8481'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8484'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8484'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8583'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8583'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8613'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8613'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8649'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8649'
        
        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8667'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8667'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8679'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8679'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8703'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8703'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8733'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8733'

        WHEN glcc.SEGMENT3 NOT LIKE '4%'
        AND glcc.SEGMENT3 NOT LIKE '5%'
        AND glcc.SEGMENT3 NOT LIKE '6%'
        THEN ''

        else 'XXX' end  "STATE_OBJ",

    --------------------------------------------
    CASE
        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG001'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '001'


        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG002'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '002'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG003'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '003'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG004'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '004'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG005'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '005'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG006'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '006'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG007'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '007'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG008'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '008'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG044'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '044'

        WHEN glcc.SEGMENT2 = '00000'
        then ''
        else 'XXX' end  "PROGRAM",

    glcc.SEGMENT2 "COST_CENTER",
    GLB.JE_SOURCE "APPL_JRNL_ID",
    GJH.POSTING_ACCT_SEQ_VALUE "SEQUENCNO",
    'TOWSON US' "LEDGER",
    TO_CHAR(GJL.EFFECTIVE_DATE, 'YYYY-MM-DD') "EFFECTIVE_DATE",
    GLCC.SEGMENT1 "FUND_CODE",
    POS.SEGMENT1 "VENDOR_ID", --SHOULD THIS BE VENDOR NUMBER? ID DOESN'T LOOK CORRECT
    hp.party_name "VENDOR_NAME",
    TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'YYYY-MM-DD') "JOURNAL_DATE", --JOURNAL EFFECTIVE DATE, CORRECT?
    GJL.JE_LINE_NUM "GL_LINE_NUM",
    GJL.ATTRIBUTE1 "JOURNAL_LINE_REF1",
    GJL.ATTRIBUTE2 "JOURNAL_LINE_REF2",
    GJL.ATTRIBUTE3 "JOURNAL_LINE_REF3",
    GJL.ATTRIBUTE4 "JOURNAL_LINE_REF4",
    GJL.ATTRIBUTE5 "JOURNAL_LINE_REF5",
    XAL.DESCRIPTION "LINE_DESC_INVOICE_NUM",
    APC.CHECK_NUMBER "PYMNT_ID", --THIS IS IN TWICE? OR WHAT IS THE DIFFERENCE
    GJL.CURRENCY_CODE "CURRENCY_CODE",
    xte.source_id_int_1

    from 
    gl_je_batches GLB

    INNER JOIN gl_je_headers GJH
    ON GLB.je_batch_id = GJH.je_batch_id

    INNER JOIN gl_je_lines GJL
    ON GJL.JE_HEADER_ID = GJH.JE_HEADER_ID

    INNER JOIN gl_je_categories_b GJC
    ON gjh.je_category = gjc.je_category_name

    INNER JOIN gl_code_combinations glcc
    ON gjl.code_combination_id = glcc.code_combination_id

    INNER JOIN gl_ledgers GLL
    ON gjh.ledger_id = gll.ledger_id

    INNER JOIN gl_periods GP
    ON gjl.period_name = gp.period_name

    left outer JOIN GL_IMPORT_REFERENCES GIR
    ON gjh.JE_HEADER_ID = gir.JE_HEADER_ID
    AND gjl.JE_HEADER_ID = gir.JE_HEADER_ID
    AND gir.JE_LINE_NUM = gjl.JE_LINE_NUM

    left outer JOIN XLA_AE_LINES XAL
    ON gir.gl_sl_link_id = xal.gl_sl_link_id
    AND gir.GL_SL_LINK_TABLE = xal.GL_SL_LINK_TABLE

    left outer JOIN XLA_AE_HEADERS XAH
    ON xal.ae_header_id = xah.ae_header_id

    left outer JOIN XLA_EVENTS XE
    ON xah.event_id = xe.event_id

    left outer JOIN xla_transaction_entities XTE
    ON xe.entity_id = xte.entity_id

    --AP_CHECKS_ALL REMOVED THE CREDITS WHEN IT WAS AN INNER JOIN
    LEFT OUTER JOIN ap_checks_all APC
    ON xte.source_id_int_1 = apc.check_id

    --IBY PAYMENTS ALL NEEDS TO LEFT OUTER JOIN, WHEN IT WAS INNER JOIN, THE CREDIT DISAPPEARED
    LEFT OUTER JOIN IBY_PAYMENTS_ALL IPA
    ON apc.payment_id = ipa.payment_id


    --AP INVOICES ALL ALL NEEDS TO LEFT OUTER JOIN, WHEN IT WAS INNER JOIN, THE CREDIT DISAPPEARED
    --Using APP AP_Invoice_Payments_all caused duplication when joining APC Ap checks all and AP invoice payments all by check id
    LEFT OUTER JOIN ap_invoices_all API
    ON XTE.SOURCE_ID_INT_1 = API.INVOICE_ID

    --POZ SUPPLIERS POS NEEDS TO LEFT OUTER JOIN, WHEN IT WAS INNER JOIN, THE CREDIT DISAPPEARED
    LEFT OUTER JOIN POZ_SUPPLIERS POS
    ON API.VENDOR_ID = POS.VENDOR_ID

    --HZ PARTIES NEEDS TO LEFT OUTER JOIN, WHEN IT WAS INNER JOIN, THE CREDIT DISAPPEARED
    LEFT OUTER JOIN hz_parties HP
    ON POS.PARTY_ID = HP.PARTY_ID

    left outer join exm_expenses EE
    ON API.REFERENCE_KEY2 = EE.EXPENSE_ID

    left outer join EXM_EXPENSE_REPORTS EER
    ON EER.EXPENSE_REPORT_ID = EE.EXPENSE_REPORT_ID

    left outer join EXM_CREDIT_CARD_TRXNS ECCT
    ON ECCT.CREDIT_CARD_TRXN_ID = EE.CREDIT_CARD_TRXN_ID

    --HR_ALL_ORGANIZATION_UNITS_F HAO,
    --HR_ORGANIZATION_UNITS_F_TL HAOT
    where 

    --and hao.ORGANIZATION_ID = haot.ORGANIZATION_ID
    glcc.segment3 like '2%'
    and gp.period_set_name = 'Monthly Adjust'
    and gll.LEDGER_CATEGORY_CODE = 'SECONDARY'
    and glb.status = 'P'
    and gll.name in ('Towson Financial Statement')
and GP.PERIOD_NAME between :P_Date_Low and :P_Date_High

UNION ALL


--union with fund 49 to bring in revenue and expenses. fund code/source code between '4900' and '4990' for fund 49 agency funds
select distinct
    TO_CHAR((ADD_MONTHS(GJH.DEFAULT_EFFECTIVE_DATE,6)),'YYYY') "FISCAL_YEAR",
    GP.PERIOD_NUM "ACCOUNTING_PERIOD",
GP.PERIOD_NAME "PERIOD_NAME",
CASE WHEN 
    XAL.ACCOUNTING_DATE IS NULL
    THEN TO_CHAR(GJH.POSTED_DATE, 'YYYY-MM-DD')
    ELSE TO_CHAR(XAL.ACCOUNTING_DATE, 'YYYY-MM-DD') 
    END AS "ACCOUNTING_DATE",
    GLCC.SEGMENT3 "ACCOUNT",
    --GLCC.SEGMENT1 "ACCOUNT_SOURCE", --JUST FOR REFERENCE 
    lpad(API.DOC_SEQUENCE_VALUE,8, '0') "VOUCHER_ID",
    CASE
    WHEN 
    gir.GL_SL_LINK_ID IS NULL
    THEN (NVL(GJL.ACCOUNTED_DR, 0)) - (NVL(GJL.ACCOUNTED_CR, 0))


    ELSE (NVL(XAL.ACCOUNTED_DR, 0)) - (NVL(XAL.ACCOUNTED_CR, 0)) END AS "MONETARY_AMOUNT",
    GLB.NAME "DESCRIPTION",
    --GJL.ATTRIBUTE2 "JOURNAL_ID", --WHAT DO WE NEED FOR THIS? SEE THE SF/AP LEAD DESIGNATION
    SUBSTR(GJC.JE_CATEGORY_KEY, 1, 3)||GJH.POSTING_ACCT_SEQ_VALUE "JOURNAL_ID",
    GJC.JE_CATEGORY_KEY "SOURCE", --TAKING JOURNAL CATEGORY NAME, IS THIS WHAT WE WANT?
    CASE WHEN IPA.DOCUMENT_SEQUENCE_VALUE IS NULL THEN '' ELSE 'VZ'||lpad(ipa.DOCUMENT_SEQUENCE_VALUE,6, '0') END AS "PMT_ID",
    -------------------------------------------------------------
    CASE WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '1000' and '4525' then '40' 

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '5001' and '5905' then '43' 

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '4600' and '4615' then '46'

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '4700' and '4725' then '47' 

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '4800' and '4890' then '48' 

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '4900' and '4990' then '49' 
    else 'XX' end as "FUND",
    ---------------------------------------------------------------------
    CASE
        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ01'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '01'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ02'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '02'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ03'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '03'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ04'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '04'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ05'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '05'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ06'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '06'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ07'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '07'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ08'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '08'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ09'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '09'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ10'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '10'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ11'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '11'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ12'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '12'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ13'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '13'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ14'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '14'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8337'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8337'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8343'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8343'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8475'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8475'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8478'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8478'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8481'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8481'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8484'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8484'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8583'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8583'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8613'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8613'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8649'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8649'
        
        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8667'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8667'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8679'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8679'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8703'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8703'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8733'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8733'

        WHEN glcc.SEGMENT3 NOT LIKE '4%'
        AND glcc.SEGMENT3 NOT LIKE '5%'
        AND glcc.SEGMENT3 NOT LIKE '6%'
        THEN ''

        else 'XXX' end  "STATE_OBJ",

    --------------------------------------------
    CASE
        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG001'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '001'


        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG002'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '002'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG003'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '003'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG004'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '004'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG005'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '005'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG006'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '006'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG007'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '007'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG008'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '008'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG044'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '044'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG042'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '042'

        WHEN glcc.SEGMENT2 = '00000'
        then ''
        else 'XXX' end  "PROGRAM",

    glcc.SEGMENT2 "COST_CENTER",
    GLB.JE_SOURCE "APPL_JRNL_ID",
    GJH.POSTING_ACCT_SEQ_VALUE "SEQUENCNO",
    'TOWSON US' "LEDGER",
    TO_CHAR(GJL.EFFECTIVE_DATE, 'YYYY-MM-DD') "EFFECTIVE_DATE",
    GLCC.SEGMENT1 "FUND_CODE",
    POS.SEGMENT1 "VENDOR_ID", --SHOULD THIS BE VENDOR NUMBER? ID DOESN'T LOOK CORRECT
    hp.party_name "VENDOR_NAME",
    TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'YYYY-MM-DD') "JOURNAL_DATE", --JOURNAL EFFECTIVE DATE, CORRECT?
    GJL.JE_LINE_NUM "GL_LINE_NUM",
    GJL.ATTRIBUTE1 "JOURNAL_LINE_REF1",
    GJL.ATTRIBUTE2 "JOURNAL_LINE_REF2",
    GJL.ATTRIBUTE3 "JOURNAL_LINE_REF3",
    GJL.ATTRIBUTE4 "JOURNAL_LINE_REF4",
    GJL.ATTRIBUTE5 "JOURNAL_LINE_REF5",
    XAL.DESCRIPTION "LINE_DESC_INVOICE_NUM",
    APC.CHECK_NUMBER "PYMNT_ID", --THIS IS IN TWICE? OR WHAT IS THE DIFFERENCE
    GJL.CURRENCY_CODE "CURRENCY_CODE",
    xte.source_id_int_1

    from 
    gl_je_batches GLB

    INNER JOIN gl_je_headers GJH
    ON GLB.je_batch_id = GJH.je_batch_id

    INNER JOIN gl_je_lines GJL
    ON GJL.JE_HEADER_ID = GJH.JE_HEADER_ID

    INNER JOIN gl_je_categories_b GJC
    ON gjh.je_category = gjc.je_category_name

    INNER JOIN gl_code_combinations glcc
    ON gjl.code_combination_id = glcc.code_combination_id

    INNER JOIN gl_ledgers GLL
    ON gjh.ledger_id = gll.ledger_id

    INNER JOIN gl_periods GP
    ON gjl.period_name = gp.period_name

--needs to be left outer join otherwise the Agency entries will be in the query results. The journal source is Spreadsheet which would be excluded
    LEFT OUTER JOIN GL_IMPORT_REFERENCES GIR
    ON gjh.JE_HEADER_ID = gir.JE_HEADER_ID
    AND gjl.JE_HEADER_ID = gir.JE_HEADER_ID
    AND gir.JE_LINE_NUM = gjl.JE_LINE_NUM

    LEFT OUTER JOIN XLA_AE_LINES XAL
    ON gir.gl_sl_link_id = xal.gl_sl_link_id
    AND gir.GL_SL_LINK_TABLE = xal.GL_SL_LINK_TABLE

    LEFT OUTER JOIN XLA_AE_HEADERS XAH
    ON xal.ae_header_id = xah.ae_header_id

    LEFT OUTER JOIN XLA_EVENTS XE
    ON xah.event_id = xe.event_id

    LEFT OUTER JOIN xla_transaction_entities XTE
    ON xe.entity_id = xte.entity_id

    --AP_CHECKS_ALL REMOVED THE CREDITS WHEN IT WAS AN INNER JOIN
    LEFT OUTER JOIN ap_checks_all APC
    ON xte.source_id_int_1 = apc.check_id

    --IBY PAYMENTS ALL NEEDS TO LEFT OUTER JOIN, WHEN IT WAS INNER JOIN, THE CREDIT DISAPPEARED
    LEFT OUTER JOIN IBY_PAYMENTS_ALL IPA
    ON apc.payment_id = ipa.payment_id


    --AP INVOICES ALL ALL NEEDS TO LEFT OUTER JOIN, WHEN IT WAS INNER JOIN, THE CREDIT DISAPPEARED
    --Using APP AP_Invoice_Payments_all caused duplication when joining APC Ap checks all and AP invoice payments all by check id
    LEFT OUTER JOIN ap_invoices_all API
    ON XTE.SOURCE_ID_INT_1 = API.INVOICE_ID

    --POZ SUPPLIERS POS NEEDS TO LEFT OUTER JOIN, WHEN IT WAS INNER JOIN, THE CREDIT DISAPPEARED
    LEFT OUTER JOIN POZ_SUPPLIERS POS
    ON API.VENDOR_ID = POS.VENDOR_ID

    --HZ PARTIES NEEDS TO LEFT OUTER JOIN, WHEN IT WAS INNER JOIN, THE CREDIT DISAPPEARED
    LEFT OUTER JOIN hz_parties HP
    ON POS.PARTY_ID = HP.PARTY_ID

    left outer join exm_expenses EE
    ON API.REFERENCE_KEY2 = EE.EXPENSE_ID

    left outer join EXM_EXPENSE_REPORTS EER
    ON EER.EXPENSE_REPORT_ID = EE.EXPENSE_REPORT_ID

    left outer join EXM_CREDIT_CARD_TRXNS ECCT
    ON ECCT.CREDIT_CARD_TRXN_ID = EE.CREDIT_CARD_TRXN_ID


    --HR_ALL_ORGANIZATION_UNITS_F HAO,
    --HR_ORGANIZATION_UNITS_F_TL HAOT
    where 

    --and hao.ORGANIZATION_ID = haot.ORGANIZATION_ID
    (glcc.segment3 like '4%'
    or glcc.segment3 like '5%'
    or glcc.segment3 like '6%')
    and gp.period_set_name = 'Monthly Adjust'
    and gll.LEDGER_CATEGORY_CODE = 'SECONDARY'
    and glb.status = 'P'
    and gll.name in ('Towson Financial Statement')
    and glcc.segment1 between '4900' and '4990'
    and GLB.JE_SOURCE NOT LIKE 'Payroll'
    and glb.actual_flag = 'A'
and GP.PERIOD_NAME between :P_Date_Low and :P_Date_High



    --AND haot.LANGUAGE='US'
    --300000016644225 TU BU ID
    --123002


    -- SELECT 
    -- *

    -- FROM GL_SEG_VAL_HIER_RF 

    -- WHERE TREE_CODE = 'Source Hierarchy'
    -- AND TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    -- where tv.TREE_VERSION_NAME = '	
    -- Source Hierarchy - Current'
    -- )


    -- CASE WHEN glcc.SEGMENT1 IN (SELECT 
    -- tree.PK1_VALUE
    -- FROM GL_SEG_VAL_HIER_RF tree
    -- where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    -- where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    -- )
    -- and tree.IS_LEAF = 'Y'
    -- and tree.distance = '4') then tree.ANCESTOR_PK1_VALUE else 'XX'

    -- SELECT 
    -- GJL.JE_LINE_NUM,
    -- (NVL(gir.REFERENCE_9, 0)) + (NVL(gir.REFERENCE_10, 0)) "MONETARY_AMOUNT"
    --  FROM

    -- gl_je_batches GLB,
    -- gl_je_headers GJH,
    -- gl_je_lines GJL,
    -- /*gl_je_categories_b GJC,*/
    -- gl_code_combinations glcC,
    -- gl_ledgers GLL,
    -- GL_IMPORT_REFERENCES GIR

    -- where GLB.je_batch_id = GJH.je_batch_id
    -- AND GJL.JE_HEADER_ID = GJH.JE_HEADER_ID
    -- and gjh.je_category = gjc.je_category_name
    -- and gjl.code_combination_id = glcc.code_combination_id
    -- and gjh.ledger_id = gll.ledger_id
    -- and gjl.je_header_id = gir.je_header_id

    -- and glcc.segment3 like '2%'
    -- AND GJL.JE_HEADER_ID = 123002

    --TREE_STRUCTURE_CODE
    --TREE_CODE
    --TREE_VERSION_ID
    --FUSION_TS_TX_IDX


UNION ALL

SELECT

    DETAILS.FISCAL_YEAR,
    DETAILS.ACCOUNTING_PERIOD,
    DETAILS.PERIOD_NAME,
    DETAILS.ACCOUNTING_DATE,
    DETAILS.ACCOUNT, 
    DETAILS.VOUCHER_ID,
    SUM(DETAILS.MONETARY_AMOUNT),
    DETAILS.DESCRIPTION,
    --GJL.ATTRIBUTE2 "JOURNAL_ID", --WHAT DO WE NEED FOR THIS? SEE THE SF/AP LEAD DESIGNATION
    DETAILS.JOURNAL_ID,
    DETAILS.SOURCE, --TAKING JOURNAL CATEGORY NAME, IS THIS WHAT WE WANT?
    DETAILS.PMT_ID,
    Details.FUND,
    Details.STATE_OBJ,
    Details.PROGRAM,
    DETAILS.COST_CENTER,
    DETAILS.APPL_JRNL_ID,
    DETAILS.SEQUENCNO,
    DETAILS.LEDGER,
    DETAILS.EFFECTIVE_DATE,
    DETAILS.FUND_CODE,
    DETAILS.VENDOR_ID, --SHOULD THIS BE VENDOR NUMBER? ID DOESN'T LOOK CORRECT
    DETAILS.VENDOR_NAME,
    DETAILS.JOURNAL_DATE, --JOURNAL EFFECTIVE DATE, CORRECT?
    DETAILS.GL_LINE_NUM,
    DETAILS.JOURNAL_LINE_REF1,
    DETAILS.JOURNAL_LINE_REF2,
    DETAILS.JOURNAL_LINE_REF3,
    DETAILS.JOURNAL_LINE_REF4,
    DETAILS.JOURNAL_LINE_REF5,
    DETAILS.LINE_DESC_INVOICE_NUM,
    DETAILS.PYMNT_ID, --THIS IS IN TWICE? OR WHAT IS THE DIFFERENCE
    DETAILS.CURRENCY_CODE,
    DETAILS.SOURCE_ID_INT_1


FROM (
--union with fund 49 to bring in revenue and expenses. fund code/source code between '4900' and '4990' for fund 49 agency funds
select distinct
    TO_CHAR((ADD_MONTHS(GJH.DEFAULT_EFFECTIVE_DATE,6)),'YYYY') "FISCAL_YEAR",
    GP.PERIOD_NUM "ACCOUNTING_PERIOD",
    GP.PERIOD_NAME "PERIOD_NAME",
    NULL "ACCOUNTING_DATE",
    NULL "ACCOUNT",
    --GLCC.SEGMENT1 "ACCOUNT_SOURCE", --JUST FOR REFERENCE 
    NULL "VOUCHER_ID",
   CASE
    WHEN 
    gir.GL_SL_LINK_ID IS NULL
    THEN (NVL(GJL.ACCOUNTED_DR, 0)) - (NVL(GJL.ACCOUNTED_CR, 0))


    ELSE (NVL(XAL.ACCOUNTED_DR, 0)) - (NVL(XAL.ACCOUNTED_CR, 0)) END AS "MONETARY_AMOUNT",
    GLB.NAME "DESCRIPTION",
    --GJL.ATTRIBUTE2 "JOURNAL_ID", --WHAT DO WE NEED FOR THIS? SEE THE SF/AP LEAD DESIGNATION
    SUBSTR(GJC.JE_CATEGORY_KEY, 1, 3)||GJH.POSTING_ACCT_SEQ_VALUE "JOURNAL_ID",
    GJC.JE_CATEGORY_KEY "SOURCE", --TAKING JOURNAL CATEGORY NAME, IS THIS WHAT WE WANT?
    NULL "PMT_ID",
    -------------------------------------------------------------
    CASE WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '1000' and '4525' then '40' 

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '5001' and '5905' then '43' 

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '4600' and '4615' then '46'

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '4700' and '4725' then '47' 

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '4800' and '4890' then '48' 

    WHEN glcc.SEGMENT1 IN (SELECT 
    tree.PK1_VALUE
    FROM GL_SEG_VAL_HIER_RF tree
    where TREE_VERSION_ID = (select tv.TREE_VERSION_ID from FND_TREE_VERSION_TL tv
    where tv.TREE_VERSION_NAME = 'Source Hierarchy - Current'
    )
    and tree.IS_LEAF = 'Y'
    and tree.distance = '4') and glcc.segment1 between '4900' and '4990' then '49' 
    else 'XX' end as "FUND",
    ---------------------------------------------------------------------
    CASE
        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ01'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '01'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ02'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '02'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ03'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '03'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ04'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '04'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ05'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '05'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ06'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '06'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ07'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '07'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ08'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '08'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ09'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '09'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ10'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '10'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ11'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '11'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ12'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '12'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ13'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '13'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'OBJ14'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '14'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8337'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8337'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8343'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8343'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8475'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8475'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8478'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8478'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8481'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8481'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8484'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8484'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8583'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8583'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8613'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8613'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8649'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8649'
        
        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8667'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8667'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8679'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8679'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8703'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8703'

        WHEN glcc.SEGMENT3 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'R8733'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '8733'

        WHEN glcc.SEGMENT3 NOT LIKE '4%'
        AND glcc.SEGMENT3 NOT LIKE '5%'
        AND glcc.SEGMENT3 NOT LIKE '6%'
        THEN ''

        else 'XXX' end  "STATE_OBJ",

    --------------------------------------------
    CASE
        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG001'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '001'


        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG002'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '002'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG003'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '003'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG004'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '004'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG005'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '005'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG006'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '006'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG007'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '007'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG008'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '008'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG044'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '044'

        WHEN glcc.SEGMENT2 IN (SELECT 
        tree.PK1_VALUE
        FROM GL_SEG_VAL_HIER_RF tree
        where
        tree.ANCESTOR_PK1_VALUE = 'PG042'
        and tree.IS_LEAF = 'Y')
        AND glcc.SEGMENT2 IS NOT NULL
        then '042'

        WHEN glcc.SEGMENT2 = '00000'
        then ''
        else 'XXX' end  "PROGRAM",

    NULL "COST_CENTER",
    GLB.JE_SOURCE "APPL_JRNL_ID",
    GJH.POSTING_ACCT_SEQ_VALUE "SEQUENCNO",
    'TOWSON US' "LEDGER",
    TO_CHAR(GJL.EFFECTIVE_DATE, 'YYYY-MM-DD') "EFFECTIVE_DATE",
    NULL "FUND_CODE",
    NULL "VENDOR_ID", --SHOULD THIS BE VENDOR NUMBER? ID DOESN'T LOOK CORRECT
    NULL "VENDOR_NAME",
    TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'YYYY-MM-DD') "JOURNAL_DATE", --JOURNAL EFFECTIVE DATE, CORRECT?
    NULL "GL_LINE_NUM",
    GJL.ATTRIBUTE1 "JOURNAL_LINE_REF1",
    NULL "JOURNAL_LINE_REF2",
    NULL "JOURNAL_LINE_REF3",
    NULL "JOURNAL_LINE_REF4",
    NULL "JOURNAL_LINE_REF5",
    NULL "LINE_DESC_INVOICE_NUM",
    NULL "PYMNT_ID", --THIS IS IN TWICE? OR WHAT IS THE DIFFERENCE
    NULL "CURRENCY_CODE",
    NULL "SOURCE_ID_INT_1"

    from 
    gl_je_batches GLB

    INNER JOIN gl_je_headers GJH
    ON GLB.je_batch_id = GJH.je_batch_id

    INNER JOIN gl_je_lines GJL
    ON GJL.JE_HEADER_ID = GJH.JE_HEADER_ID

    INNER JOIN gl_je_categories_b GJC
    ON gjh.je_category = gjc.je_category_name

    INNER JOIN gl_code_combinations glcc
    ON gjl.code_combination_id = glcc.code_combination_id

    INNER JOIN gl_ledgers GLL
    ON gjh.ledger_id = gll.ledger_id

    INNER JOIN gl_periods GP
    ON gjl.period_name = gp.period_name

--needs to be left outer join otherwise the Agency entries will be in the query results. The journal source is Spreadsheet which would be excluded
    LEFT OUTER JOIN GL_IMPORT_REFERENCES GIR
    ON gjh.JE_HEADER_ID = gir.JE_HEADER_ID
    AND gjl.JE_HEADER_ID = gir.JE_HEADER_ID
    AND gir.JE_LINE_NUM = gjl.JE_LINE_NUM

    LEFT OUTER JOIN XLA_AE_LINES XAL
    ON gir.gl_sl_link_id = xal.gl_sl_link_id
    AND gir.GL_SL_LINK_TABLE = xal.GL_SL_LINK_TABLE

    LEFT OUTER JOIN XLA_AE_HEADERS XAH
    ON xal.ae_header_id = xah.ae_header_id

    LEFT OUTER JOIN XLA_EVENTS XE
    ON xah.event_id = xe.event_id

    LEFT OUTER JOIN xla_transaction_entities XTE
    ON xe.entity_id = xte.entity_id

    --AP_CHECKS_ALL REMOVED THE CREDITS WHEN IT WAS AN INNER JOIN
    LEFT OUTER JOIN ap_checks_all APC
    ON xte.source_id_int_1 = apc.check_id

    --IBY PAYMENTS ALL NEEDS TO LEFT OUTER JOIN, WHEN IT WAS INNER JOIN, THE CREDIT DISAPPEARED
    LEFT OUTER JOIN IBY_PAYMENTS_ALL IPA
    ON apc.payment_id = ipa.payment_id


    --AP INVOICES ALL ALL NEEDS TO LEFT OUTER JOIN, WHEN IT WAS INNER JOIN, THE CREDIT DISAPPEARED
    --Using APP AP_Invoice_Payments_all caused duplication when joining APC Ap checks all and AP invoice payments all by check id
    LEFT OUTER JOIN ap_invoices_all API
    ON XTE.SOURCE_ID_INT_1 = API.INVOICE_ID

    --POZ SUPPLIERS POS NEEDS TO LEFT OUTER JOIN, WHEN IT WAS INNER JOIN, THE CREDIT DISAPPEARED
    LEFT OUTER JOIN POZ_SUPPLIERS POS
    ON API.VENDOR_ID = POS.VENDOR_ID

    --HZ PARTIES NEEDS TO LEFT OUTER JOIN, WHEN IT WAS INNER JOIN, THE CREDIT DISAPPEARED
    LEFT OUTER JOIN hz_parties HP
    ON POS.PARTY_ID = HP.PARTY_ID

    left outer join exm_expenses EE
    ON API.REFERENCE_KEY2 = EE.EXPENSE_ID

    left outer join EXM_EXPENSE_REPORTS EER
    ON EER.EXPENSE_REPORT_ID = EE.EXPENSE_REPORT_ID

    left outer join EXM_CREDIT_CARD_TRXNS ECCT
    ON ECCT.CREDIT_CARD_TRXN_ID = EE.CREDIT_CARD_TRXN_ID


    --HR_ALL_ORGANIZATION_UNITS_F HAO,
    --HR_ORGANIZATION_UNITS_F_TL HAOT
    where 

    --and hao.ORGANIZATION_ID = haot.ORGANIZATION_ID
    (glcc.segment3 like '4%'
    or glcc.segment3 like '5%'
    or glcc.segment3 like '6%')
    and gp.period_set_name = 'Monthly Adjust'
    and gll.LEDGER_CATEGORY_CODE = 'SECONDARY'
    and glb.status = 'P'
    and gll.name in ('Towson Financial Statement')
    and glcc.segment1 between '4900' and '4990'
    and GLB.JE_SOURCE = 'Payroll'
    and glb.actual_flag = 'A'
and GP.PERIOD_NAME between :P_Date_Low and :P_Date_High

)  Details

     GROUP BY
--need to group to group the payroll entries together and union them. payroll does not have GIR values to join on because having those fields prevents grouping such as account number, cost center. those are not on the sample report
 --exclude monetary amount from grouping in order to sum it for payroll
 --THIS GROUPING IS FOR AGENCY FUND PAYROLL FUND 49
    DETAILS.FISCAL_YEAR,
    DETAILS.ACCOUNTING_PERIOD,
    DETAILS.PERIOD_NAME,
    DETAILS.ACCOUNTING_DATE,
    DETAILS.ACCOUNT, 
    DETAILS.VOUCHER_ID,
    DETAILS.DESCRIPTION,
    --GJL.ATTRIBUTE2 "JOURNAL_ID", --WHAT DO WE NEED FOR THIS? SEE THE SF/AP LEAD DESIGNATION
    DETAILS.JOURNAL_ID,
    DETAILS.SOURCE, --TAKING JOURNAL CATEGORY NAME, IS THIS WHAT WE WANT?
    DETAILS.PMT_ID,
    Details.FUND,
    Details.STATE_OBJ,
    Details.PROGRAM,
    DETAILS.COST_CENTER,
    DETAILS.APPL_JRNL_ID,
    DETAILS.SEQUENCNO,
    DETAILS.LEDGER,
    DETAILS.EFFECTIVE_DATE,
    DETAILS.FUND_CODE,
    DETAILS.VENDOR_ID, --SHOULD THIS BE VENDOR NUMBER? ID DOESN'T LOOK CORRECT
    DETAILS.VENDOR_NAME,
    DETAILS.JOURNAL_DATE, --JOURNAL EFFECTIVE DATE, CORRECT?
    DETAILS.GL_LINE_NUM,
    DETAILS.JOURNAL_LINE_REF1,
    DETAILS.JOURNAL_LINE_REF2,
    DETAILS.JOURNAL_LINE_REF3,
    DETAILS.JOURNAL_LINE_REF4,
    DETAILS.JOURNAL_LINE_REF5,
    DETAILS.LINE_DESC_INVOICE_NUM,
    DETAILS.PYMNT_ID, --THIS IS IN TWICE? OR WHAT IS THE DIFFERENCE
    DETAILS.CURRENCY_CODE,
    DETAILS.SOURCE_ID_INT_1
