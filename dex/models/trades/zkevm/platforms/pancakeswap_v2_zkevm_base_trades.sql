{{
    config(
        schema = 'pancakeswap_v2_zkevm',
        alias = 'base_trades',
        materialized = 'incremental',
        file_format = 'delta',
        incremental_strategy = 'merge',
        unique_key = ['tx_hash', 'evt_index'],
        incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.block_time')]
    )
}}

{{
    uniswap_compatible_v2_trades(
        blockchain = 'zkevm',
        project = 'pancakeswap',
        version = '2',
        Pair_evt_Swap = source('pancakeswap_v2_zkevm', 'PancakePair_evt_Swap'),
        Factory_evt_PairCreated = source('pancakeswap_v2_zkevm', 'PancakeFactory_evt_PairCreated')
    )
}}
