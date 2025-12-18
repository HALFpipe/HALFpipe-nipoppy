#!/usr/bin/env bash

bids_directory=$1
working_directory=$2
skull_strip_algorithm=$3
run_reconall=$4

base_directory="$(dirname "$0")"

smoothing="\"smoothing\": {\"fwhm\": 6.0}"
motion_parameters='"(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2"'

base="\"output_image\": false, \"space\": \"standard\", \"grand_mean_scaling\": {\"mean\": 10000.0}"
gaussian_bandpass_filter="${base}, \"bandpass_filter\": {\"type\": \"gaussian\", \"hp_width\": 125.0, \"lp_width\": null}"
gaussian_bandpass_filter_smoothing="${base}, ${smoothing}"
frequency_based_bandpass_filter="${base}, \"bandpass_filter\": {\"type\": \"frequency_based\", \"high\": 0.1, \"low\": 0.01}"

atlas_based_connectivity="\"type\": \"atlas_based_connectivity\", \"atlases\": [\"Schaefer2018Combined\"], \"min_region_coverage\": 0.5"
seed_based_connectivity="\"type\": \"seed_based_connectivity\", \"seeds\": [\"L_putamen\", \"R_putamen\", \"L_antInsula\", \"R_antInsula\", \"L_hippocampus\", \"R_hippocampus\", \"L_thalamus\", \"R_thalamus\", \"L_rACC\", \"R_rACC\", \"Middle_PCC\", \"L_caudate\", \"R_caudate\", \"L_amygdala\", \"R_amygdala\", \"L_postInsula\", \"R_postInsula\", \"L_dACC\", \"R_dACC\"], \"min_seed_coverage\": 0.5"
reho="\"type\": \"reho\", ${smoothing}, \"zscore\": false"
falff="\"type\": \"falff\", ${smoothing}, \"zscore\": false"

touch "${working_directory}/log.txt" "${working_directory}/err.txt"

cat <<EOF > "${working_directory}/spec.json"
{
    "halfpipe_version": "1.3.0",
    "schema_version": "3.0",
    "timestamp": "2022-07-13_14-38",
    "global_settings": {
        "dummy_scans": null,
        "slice_timing": true,
        "use_bbr": null,
        "skull_strip_algorithm": "${skull_strip_algorithm}",
        "run_mriqc": false,
        "run_fmriprep": true,
        "run_halfpipe": true,
        "fd_thres": 0.5,
        "anat_only": false,
        "write_graph": false,
        "hires": false,
        "run_reconall": ${run_reconall},
        "t2s_coreg": false,
        "medial_surface_nan": false,
        "bold2t1w_dof": 9,
        "fmap_bspline": true,
        "force_syn": false,
        "longitudinal": false,
        "regressors_all_comps": false,
        "regressors_dvars_th": 1.5,
        "regressors_fd_th": 0.5,
        "skull_strip_fixed_seed": false,
        "skull_strip_template": "OASIS30ANTs",
        "aroma_err_on_warn": false,
        "aroma_melodic_dim": -200,
        "sloppy": false
    },
    "files": [
        {"datatype": "bids", "path": "${bids_directory}"},
        {"datatype": "ref", "suffix": "atlas", "extension": ".nii.gz", "path": "${base_directory}/atlas-{desc}_dseg.nii.gz"},
        {"datatype": "ref", "suffix": "seed", "extension": ".nii.gz", "path": "${base_directory}/{desc}_seed_2009.nii.gz"}
    ],
    "settings": [
        {"name": "cCompCorCorrMatrixSetting", "confounds_removal": ["c_comp_cor_0[0-4]"], "ica_aroma": false, ${gaussian_bandpass_filter}},
        {"name": "motionParametersScrubbingCorrMatrixSetting", "confounds_removal": [${motion_parameters}, "motion_outlier[0-9]+"], "ica_aroma": false, ${gaussian_bandpass_filter}},
        {"name": "motionParametersScrubbingGSRCorrMatrixSetting", "confounds_removal": [${motion_parameters}, "motion_outlier[0-9]+", "global_signal"], "ica_aroma": false, ${gaussian_bandpass_filter}},
        {"name": "motionParametersCorrMatrixSetting", "confounds_removal": [${motion_parameters}], "ica_aroma": false, ${gaussian_bandpass_filter}},
        {"name": "motionParametersGSRCorrMatrixSetting", "confounds_removal": [${motion_parameters}, "global_signal"], "ica_aroma": false, ${gaussian_bandpass_filter}},
       
        {"name": "cCompCorSeedCorrSetting", "confounds_removal": ["c_comp_cor_0[0-4]"], "ica_aroma": false, ${gaussian_bandpass_filter_smoothing}},
        {"name": "motionParametersScrubbingSeedCorrSetting", "confounds_removal": [${motion_parameters}, "motion_outlier[0-9]+"], "ica_aroma": false, ${gaussian_bandpass_filter_smoothing}},
        {"name": "motionParametersScrubbingGSRSeedCorrSetting", "confounds_removal": [${motion_parameters}, "motion_outlier[0-9]+", "global_signal"], "ica_aroma": false, ${gaussian_bandpass_filter_smoothing}},
        {"name": "motionParametersSeedCorrSetting", "confounds_removal": [${motion_parameters}], "ica_aroma": false, ${gaussian_bandpass_filter_smoothing}},
        {"name": "motionParametersGSRSeedCorrSetting", "confounds_removal": [${motion_parameters}, "global_signal"], "ica_aroma": false, ${gaussian_bandpass_filter_smoothing}},
    
        {"name": "cCompCorFALFFReHoSetting", "confounds_removal": ["c_comp_cor_0[0-4]"], "ica_aroma": false, ${frequency_based_bandpass_filter}},
        {"name": "motionParametersScrubbingFALFFReHoSetting", "confounds_removal": [${motion_parameters}, "motion_outlier[0-9]+"], "ica_aroma": false, ${frequency_based_bandpass_filter}},
        {"name": "motionParametersScrubbingGSRFALFFReHoSetting", "confounds_removal": [${motion_parameters}, "motion_outlier[0-9]+", "global_signal"], "ica_aroma": false, ${frequency_based_bandpass_filter}},
        {"name": "motionParametersFALFFReHoSetting", "confounds_removal": [${motion_parameters}], "ica_aroma": false, ${frequency_based_bandpass_filter}},
        {"name": "motionParametersGSRFALFFReHoSetting", "confounds_removal": [${motion_parameters}, "global_signal"], "ica_aroma": false, ${frequency_based_bandpass_filter}},
        
        {"name": "cCompCorSetting", "confounds_removal": ["c_comp_cor_0[0-4]"], "ica_aroma": false, ${base}},
        {"name": "motionParametersScrubbingSetting", "confounds_removal": [${motion_parameters}, "motion_outlier[0-9]+"], "ica_aroma": false, ${base}},
        {"name": "motionParametersScrubbingGSRSetting", "confounds_removal": [${motion_parameters}, "motion_outlier[0-9]+", "global_signal"], "ica_aroma": false, ${base}},
        {"name": "motionParametersSetting", "confounds_removal": [${motion_parameters}], "ica_aroma": false, ${base}},
        {"name": "motionParametersGSRSetting", "confounds_removal": [${motion_parameters}, "global_signal"], "ica_aroma": false, ${base}}
    ],
    "features": [
        {"name": "cCompCorCorrMatrix", "setting": "cCompCorCorrMatrixSetting", ${atlas_based_connectivity}},
        {"name": "motionParametersScrubbingCorrMatrix", "setting": "motionParametersScrubbingCorrMatrixSetting", ${atlas_based_connectivity}},
        {"name": "motionParametersScrubbingGSRCorrMatrix", "setting": "motionParametersScrubbingGSRCorrMatrixSetting", ${atlas_based_connectivity}},
        {"name": "motionParametersCorrMatrix", "setting": "motionParametersCorrMatrixSetting", ${atlas_based_connectivity}},
        {"name": "motionParametersGSRCorrMatrix", "setting": "motionParametersGSRCorrMatrixSetting", ${atlas_based_connectivity}},
        
        {"name": "cCompCorSeedCorr", "setting": "cCompCorSeedCorrSetting", ${seed_based_connectivity}},
        {"name": "motionParametersScrubbingSeedCorr", "setting": "motionParametersScrubbingSeedCorrSetting", ${seed_based_connectivity}},
        {"name": "motionParametersScrubbingGSRSeedCorr", "setting": "motionParametersScrubbingGSRSeedCorrSetting", ${seed_based_connectivity}},
        {"name": "motionParametersSeedCorr", "setting": "motionParametersSeedCorrSetting", ${seed_based_connectivity}},
        {"name": "motionParametersGSRSeedCorr", "setting": "motionParametersGSRSeedCorrSetting", ${seed_based_connectivity}},

        {"name": "cCompCorReHo", "setting": "cCompCorFALFFReHoSetting", ${reho}},
        {"name": "motionParametersScrubbingReHo", "setting": "motionParametersScrubbingFALFFReHoSetting", ${reho}},
        {"name": "motionParametersScrubbingGSRReHo", "setting": "motionParametersScrubbingGSRFALFFReHoSetting", ${reho}},
        {"name": "motionParametersReHo", "setting": "motionParametersFALFFReHoSetting", ${reho}},
        {"name": "motionParametersGSRReHo", "setting": "motionParametersGSRFALFFReHoSetting", ${reho}},

        {"name": "cCompCorFALFF", "setting": "cCompCorFALFFReHoSetting", "unfiltered_setting": "cCompCorSetting", ${falff}},
        {"name": "motionParametersScrubbingFALFF", "setting": "motionParametersScrubbingFALFFReHoSetting", "unfiltered_setting": "motionParametersScrubbingSetting", ${falff}},
        {"name": "motionParametersScrubbingGSRFALFF", "setting": "motionParametersScrubbingGSRFALFFReHoSetting", "unfiltered_setting": "motionParametersScrubbingGSRSetting", ${falff}},
        {"name": "motionParametersFALFF", "setting": "motionParametersFALFFReHoSetting", "unfiltered_setting": "motionParametersSetting", ${falff}},
        {"name": "motionParametersGSRFALFF", "setting": "motionParametersGSRFALFFReHoSetting", "unfiltered_setting": "motionParametersGSRSetting", ${falff}}
    ],
    "models": []
}
EOF
