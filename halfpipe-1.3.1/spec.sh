#!/bin/bash

bids_directory=$1
working_directory=$2

base_directory="$(dirname "$0")"

cat <<EOF > "${working_directory}/spec.json"
{
    "halfpipe_version": "1.3.0",
    "schema_version": "3.0",
    "timestamp": "2022-07-13_14-38",
    "global_settings": {
        "dummy_scans": null,
        "slice_timing": true,
        "use_bbr": null,
        "skull_strip_algorithm": "none",
        "run_mriqc": false,
        "run_fmriprep": true,
        "run_halfpipe": true,
        "fd_thres": 0.5,
        "anat_only": false,
        "write_graph": false,
        "hires": false,
        "run_reconall": false,
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
        {"name": "cCompCorCorrMatrixSetting", "confounds_removal": ["c_comp_cor_0[0-4]"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "bandpass_filter": {"type": "gaussian", "hp_width": 125.0, "lp_width": null}},
        {"name": "motionParametersScrubbingCorrMatrixSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2", "motion_outlier[0-9]+"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "bandpass_filter": {"type": "gaussian", "hp_width": 125.0, "lp_width": null}},
        {"name": "motionParametersScrubbingGSRCorrMatrixSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2", "motion_outlier[0-9]+", "global_signal"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "bandpass_filter": {"type": "gaussian", "hp_width": 125.0, "lp_width": null}},
        {"name": "motionParametersCorrMatrixSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "bandpass_filter": {"type": "gaussian", "hp_width": 125.0, "lp_width": null}},
        {"name": "motionParametersGSRCorrMatrixSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2", "global_signal"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "bandpass_filter": {"type": "gaussian", "hp_width": 125.0, "lp_width": null}},

        {"name": "cCompCorSeedCorrSetting", "confounds_removal": ["c_comp_cor_0[0-4]"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "smoothing": {"fwhm": 6.0}},
        {"name": "motionParametersScrubbingSeedCorrSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2", "motion_outlier[0-9]+"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "smoothing": {"fwhm": 6.0}},
        {"name": "motionParametersScrubbingGSRSeedCorrSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2", "motion_outlier[0-9]+", "global_signal"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "smoothing": {"fwhm": 6.0}},
        {"name": "motionParametersSeedCorrSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "smoothing": {"fwhm": 6.0}},
        {"name": "motionParametersGSRSeedCorrSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2", "global_signal"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "smoothing": {"fwhm": 6.0}},

        {"name": "cCompCorFALFFReHoSetting", "confounds_removal": ["c_comp_cor_0[0-4]"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "bandpass_filter": {"type": "frequency_based", "high": 0.1, "low": 0.01}},
        {"name": "motionParametersScrubbingFALFFReHoSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2", "motion_outlier[0-9]+"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "bandpass_filter": {"type": "frequency_based", "high": 0.1, "low": 0.01}},
        {"name": "motionParametersScrubbingGSRFALFFReHoSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2", "motion_outlier[0-9]+", "global_signal"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "bandpass_filter": {"type": "frequency_based", "high": 0.1, "low": 0.01}},
        {"name": "motionParametersFALFFReHoSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "bandpass_filter": {"type": "frequency_based", "high": 0.1, "low": 0.01}},
        {"name": "motionParametersGSRFALFFReHoSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2", "global_signal"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}, "bandpass_filter": {"type": "frequency_based", "high": 0.1, "low": 0.01}},

        {"name": "cCompCorSetting", "confounds_removal": ["c_comp_cor_0[0-4]"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}},
        {"name": "motionParametersScrubbingSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2", "motion_outlier[0-9]+"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}},
        {"name": "motionParametersScrubbingGSRSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2", "motion_outlier[0-9]+", "global_signal"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}},
        {"name": "motionParametersSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}},
        {"name": "motionParametersGSRSetting", "confounds_removal": ["(trans|rot)_[xyz]", "(trans|rot)_[xyz]_derivative1", "(trans|rot)_[xyz]_power2", "(trans|rot)_[xyz]_derivative1_power2", "global_signal"], "ica_aroma": false, "output_image": false, "space": "standard", "grand_mean_scaling": {"mean": 10000.0}},
    ],
    "features": [
        {"name": "cCompCorCorrMatrix", "setting": "cCompCorCorrMatrixSetting", "type": "atlas_based_connectivity", "atlases": ["Schaefer2018Combined"], "min_region_coverage": 0.5},
        {"name": "motionParametersScrubbingCorrMatrix", "setting": "motionParametersScrubbingCorrMatrixSetting", "type": "atlas_based_connectivity", "atlases": ["Schaefer2018Combined"], "min_region_coverage": 0.5},
        {"name": "motionParametersScrubbingGSRCorrMatrix", "setting": "motionParametersScrubbingGSRCorrMatrixSetting", "type": "atlas_based_connectivity", "atlases": ["Schaefer2018Combined"], "min_region_coverage": 0.5},
        {"name": "motionParametersCorrMatrix", "setting": "motionParametersCorrMatrixSetting", "type": "atlas_based_connectivity", "atlases": ["Schaefer2018Combined"], "min_region_coverage": 0.5},
        {"name": "motionParametersGSRCorrMatrix", "setting": "motionParametersGSRCorrMatrixSetting", "type": "atlas_based_connectivity", "atlases": ["Schaefer2018Combined"], "min_region_coverage": 0.5},

        {"name": "cCompCorSeedCorr", "setting": "cCompCorSeedCorrSetting", "type": "seed_based_connectivity", "seeds": ["L_putamen", "R_putamen", "L_antInsula", "R_antInsula", "L_hippocampus", "R_hippocampus", "L_thalamus", "R_thalamus", "L_rACC", "R_rACC", "Middle_PCC", "L_caudate", "R_caudate", "L_amygdala", "R_amygdala", "L_postInsula", "R_postInsula", "L_dACC", "R_dACC"], "min_seed_coverage": 0.5},
        {"name": "motionParametersScrubbingSeedCorr", "setting": "motionParametersScrubbingSeedCorrSetting", "type": "seed_based_connectivity", "seeds": ["L_putamen", "R_putamen", "L_antInsula", "R_antInsula", "L_hippocampus", "R_hippocampus", "L_thalamus", "R_thalamus", "L_rACC", "R_rACC", "Middle_PCC", "L_caudate", "R_caudate", "L_amygdala", "R_amygdala", "L_postInsula", "R_postInsula", "L_dACC", "R_dACC"], "min_seed_coverage": 0.5},
        {"name": "motionParametersScrubbingGSRSeedCorr", "setting": "motionParametersScrubbingGSRSeedCorrSetting", "type": "seed_based_connectivity", "seeds": ["L_putamen", "R_putamen", "L_antInsula", "R_antInsula", "L_hippocampus", "R_hippocampus", "L_thalamus", "R_thalamus", "L_rACC", "R_rACC", "Middle_PCC", "L_caudate", "R_caudate", "L_amygdala", "R_amygdala", "L_postInsula", "R_postInsula", "L_dACC", "R_dACC"], "min_seed_coverage": 0.5},
        {"name": "motionParametersSeedCorr", "setting": "motionParametersSeedCorrSetting", "type": "seed_based_connectivity", "seeds": ["L_putamen", "R_putamen", "L_antInsula", "R_antInsula", "L_hippocampus", "R_hippocampus", "L_thalamus", "R_thalamus", "L_rACC", "R_rACC", "Middle_PCC", "L_caudate", "R_caudate", "L_amygdala", "R_amygdala", "L_postInsula", "R_postInsula", "L_dACC", "R_dACC"], "min_seed_coverage": 0.5},
        {"name": "motionParametersGSRSeedCorr", "setting": "motionParametersGSRSeedCorrSetting", "type": "seed_based_connectivity", "seeds": ["L_putamen", "R_putamen", "L_antInsula", "R_antInsula", "L_hippocampus", "R_hippocampus", "L_thalamus", "R_thalamus", "L_rACC", "R_rACC", "Middle_PCC", "L_caudate", "R_caudate", "L_amygdala", "R_amygdala", "L_postInsula", "R_postInsula", "L_dACC", "R_dACC"], "min_seed_coverage": 0.5},

        {"name": "cCompCorReHo", "setting": "cCompCorFALFFReHoSetting", "type": "reho", "smoothing": {"fwhm": 6.0}, "zscore": false},
        {"name": "motionParametersScrubbingReHo", "setting": "motionParametersScrubbingFALFFReHoSetting", "type": "reho", "smoothing": {"fwhm": 6.0}, "zscore": false},
        {"name": "motionParametersScrubbingGSRReHo", "setting": "motionParametersScrubbingGSRFALFFReHoSetting", "type": "reho", "smoothing": {"fwhm": 6.0}, "zscore": false},
        {"name": "motionParametersReHo", "setting": "motionParametersFALFFReHoSetting", "type": "reho", "smoothing": {"fwhm": 6.0}, "zscore": false},
        {"name": "motionParametersGSRReHo", "setting": "motionParametersGSRFALFFReHoSetting", "type": "reho", "smoothing": {"fwhm": 6.0}, "zscore": false},

        {"name": "cCompCorFALFF", "setting": "cCompCorFALFFReHoSetting", "unfiltered_setting": "cCompCorSetting", "type": "falff", "smoothing": {"fwhm": 6.0}, "zscore": false},
        {"name": "motionParametersScrubbingFALFF", "setting": "motionParametersScrubbingFALFFReHoSetting", "unfiltered_setting": "motionParametersScrubbingSetting", "type": "falff", "smoothing": {"fwhm": 6.0}, "zscore": false},
        {"name": "motionParametersScrubbingGSRFALFF", "setting": "motionParametersScrubbingGSRFALFFReHoSetting", "unfiltered_setting": "motionParametersScrubbingGSRSetting", "type": "falff", "smoothing": {"fwhm": 6.0}, "zscore": false},
        {"name": "motionParametersFALFF", "setting": "motionParametersFALFFReHoSetting", "unfiltered_setting": "motionParametersSetting", "type": "falff", "smoothing": {"fwhm": 6.0}, "zscore": false},
        {"name": "motionParametersGSRFALFF", "setting": "motionParametersGSRFALFFReHoSetting", "unfiltered_setting": "motionParametersGSRSetting", "type": "falff", "smoothing": {"fwhm": 6.0}, "zscore": false}
    ],
    "models": []
}
EOF
