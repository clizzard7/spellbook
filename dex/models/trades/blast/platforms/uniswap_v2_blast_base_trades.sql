{{
    config(
        schema = 'uniswap_v2_blast',
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
        blockchain = 'blast',
        project = 'uniswap',
        version = '2',
        Pair_evt_Swap = source('uniswap_v2_blast', 'Pair_evt_Swap'),
        Factory_evt_PairCreated = source('uniswap_v2_blast', 'UniswapV2Factory_evt_PairCreated')
    )
}}
