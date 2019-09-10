# -*- coding: utf-8 -*-
"""
Created on Thu Aug 29 15:34:05 2019

@author: NUS
"""
import numpy as np 
#####################################################K-means clustering###########################################
# randomly select the centroids
import random
import math
def randCent(data,k):
    """random gengerate the centroids
    parameters
    ------------
    data: <class 'numpy.ndarray'>, shape=[n_samples, n_features], input data to be randomly select centorids.
            
    k:    <class 'int'>   the number of the centroids
    ------------
    return
        centroids: <class 'numpy.ndarray'>, shape=[k, n_features]
    """
    index = set()
    while len(index) != k:
        index.add(random.randint(0, data.shape[0]))
    index = list(index)
    centroids = data[index]
    return centroids
def KMeans(data,k):
    """ KMeans algorithm 
    parameters
    ------------
    data: <class 'numpy.ndarray'>, shape=[n_samples, n_features], input data to be randomly select centorids.
            
    k:    <class 'int'>   the number of the centroids
    ------------
    return
        centroids: <class 'numpy.ndarray'>, shape=[k, n_features]
        clusterAssment:  <class 'numpy.matrix'>, shape=[n_samples, 1]
    """
    centroids = randCent(data, k)
    clusterAssment = np.zeros(shape=(data.shape[0],1))
    flag = True
    # time_of_it = 0
    while flag:
        # print("enter " + str(time_of_it) + "  \'s iteration!")
        # time_of_it += 1
        # print("centers:")
        # print(centroids)
        for i in range(data.shape[0]):
            point = data[i]
            distance_list = [0.0 for n in range(0, k)]
            distance = np.array(distance_list)
            for j in range(k):
                temp_centroid = centroids[j]
                # print("point")
                # print(point)
                # print("center")
                # print(temp_centroid)
                distance[j] = math.pow((temp_centroid[0] - point[0]), 2) + math.pow((temp_centroid[1] - point[1]), 2)
                # print("distance")
                # print(distance)
                # print("index")
                cluster = distance.argmin()
                clusterAssment[i] = cluster
                # print(cluster)
        new_centroids = np.zeros(shape=(k,data.shape[1]))
        for i in range(k):
            points_index = np.where(clusterAssment==i)
            points = data[points_index[0]]
            new_centroids[i] = np.mean(points, axis=0)
            # print("point_index")
            # print(points_index)
        # print("new_centroids:")
        # print(new_centroids)
        # print("difference:" + str(np.sum(np.abs(new_centroids - centroids))))
        # print(new_centroids.shape)
        # print(centroids.shape)
        # print(np.abs(new_centroids - centroids))
        if np.sum(np.abs(new_centroids - centroids)) < 1e-10:
            flag = False
        centroids = new_centroids
    return centroids, clusterAssment

##############################################color #############################################################
def colors(k):
    """ generate the color for the plt.scatter
    parameters
    ------------
    k:    <class 'int'>   the number of the centroids
    ------------
    return
        ret: <class 'list'>, len = k
    """    
    ret = []
    for i in range(k):
        ret.append((random.uniform(0, 1), random.uniform(0, 1), random.uniform(0, 1)))
    return ret


############################################mean shift clustering##############################################
from collections import defaultdict
import warnings
from sklearn.neighbors import NearestNeighbors
from sklearn.utils._joblib import Parallel
from sklearn.utils._joblib import delayed
 
def _mean_shift_single_seed(my_mean, X, nbrs, max_iter):
    """mean shift cluster for single seed.
    Parameters
    ----------
    X : array-like, shape=[n_samples, n_features]
        Samples to cluster.
    nbrs: NearestNeighbors(radius=bandwidth, n_jobs=1).fit(X)
    max_iter: max interations 
    return:
        mean(center) and the total number of pixels which is in the sphere
    """
    # For each seed, climb gradient until convergence or max_iter


def mean_shift(X, bandwidth=None, seeds=None, bin_seeding=False,min_bin_freq=1, cluster_all=True, max_iter=300,
               n_jobs=None):
    """pipline of mean shift clustering
    Parameters
    ----------
    X : array-like, shape=[n_samples, n_features]
    bandwidth: the radius of the sphere
    seeds: whether use the bin seed algorithm to generate the initial seeds
    bin_size:    bin_size = bandwidth.
    min_bin_freq: for each bin_seed, the minimize of the points should cover
    return:
        cluster_centers <class 'numpy.ndarray'> shape=[n_cluster, n_features] ,labels <class 'list'>, len = n_samples
    """
    print(get_bin_seeds(X, bin_seeding))
    # find the points within the sphere
    nbrs = NearestNeighbors(radius=bandwidth, n_jobs=1).fit(X)
    ##########################################parallel computing############################
    center_intensity_dict = {}
    all_res = Parallel(n_jobs=n_jobs)(
        delayed(_mean_shift_single_seed)
        (seed, X, nbrs, max_iter) for seed in seeds)#
    ##########################################parallel computing############################

    return cluster_centers, labels
def get_bin_seeds(X, bin_size, min_bin_freq=1):
    """generate the initial seeds, in order to use the parallel computing 
    Parameters
    ----------
    X : array-like, shape=[n_samples, n_features]
    bin_size:    bin_size = bandwidth.
    min_bin_freq: for each bin_seed, the minimize of the points should cover
    return:
        bin_seeds: dict-like bin_seeds = {key=seed, key_value=he total number of pixels which is in the sphere }
    """
    # Bin points
    pseudo_labels = np.round(X/bin_size)
    bin_seeds = {}
    for i in pseudo_labels:
        i = tuple(i)
        if i not in bin_seeds:
            bin_seeds[i] = 0
        else:
            bin_seeds[i] += 1
    return bin_seeds
