#!/bin/fish

function pvs_discover
    doas pvs --options=pv_name,vg_name --separator=: --noheadings
end

function pvs_data
    doas pvs --options=pv_name,vg_name,pv_attr,pv_size,pv_free \
        --separator=: --units=B --nosuffix --noheadings \
        $argv[1]
end

function vgs_discover
    doas vgs --options=vg_name --noheadings
end

function vgs_data
    doas vgs --options=vg_name,vg_attr,vg_size,vg_free \
        --separator=: --units=B --nosuffix --noheadings \
        $argv[1]
end

function lvs_discover
    doas lvs --options=vg_name,lv_name --separator=: --noheadings
end

function lvs_data
    set -l parts (string split : $argv[1])
    doas lvs --options=vg_name,lv_name,lv_attr,lv_size,data_percent,metadata_percent,pool_lv \
        --separator=: --units=B --nosuffix --noheadings \
        $parts[1]/$parts[2]
end

if test -z $argv[1]
    set -l self (status filename)
    echo "usage: $self (pvs|vgs|lvs)_(discover|data)"
    return 1
end
"$argv[1]" $argv[2]
