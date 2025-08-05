# 📊 Hap.py Results Visualization Toolkit

A comprehensive Python toolkit for visualizing and analyzing variant calling performance metrics from hap.py (Happy) benchmarking results. This project generates publication-ready plots and performance summaries for genomic variant calling pipelines.

## 🎯 Overview

This toolkit provides automated visualization and analysis of variant calling accuracy using hap.py output files. It's designed to evaluate the performance of variant callers like DeepVariant against gold standard truth sets such as GIAB (Genome in a Bottle), generating comprehensive performance dashboards and detailed analysis plots.

## ✨ Key Features

### 📈 Multi-Panel Performance Dashboard
- **4-Panel Summary View**: Comprehensive overview with variant counts, TP/FP/FN analysis, precision/recall metrics, and performance heatmaps
- **Publication-Ready Quality**: High-resolution (300 DPI) outputs with professional styling
- **Automated Font Scaling**: Consistent typography with proper font sizes for all elements

### 📊 Detailed Analysis Visualizations
- **Precision-Recall Curves**: Interactive curves with QQ value thresholds for SNPs and INDELs
- **F1 Score Optimization**: Quality threshold analysis for optimal performance
- **QUAL Distribution Analysis**: Input VCF quality score histograms with KDE curves
- **Performance Heatmaps**: Comprehensive metric visualization

### 🔍 Supported Metrics
- **Precision**: TP / (TP + FP) - Accuracy of positive predictions
- **Recall (Sensitivity)**: TP / (TP + FN) - Coverage of true positives
- **F1 Score**: Harmonic mean of precision and recall
- **QQ Values**: Quality thresholds for performance optimization
- **True/False Positives and False Negatives**: Detailed classification metrics

### 📁 Data Type Support
- **SNPs**: Single Nucleotide Polymorphisms
- **INDELs**: Insertions and Deletions
- **Truth vs Query Comparisons**: Benchmark vs test dataset analysis

## 🚀 Quick Start

### Prerequisites
```bash
pip install pandas numpy matplotlib seaborn