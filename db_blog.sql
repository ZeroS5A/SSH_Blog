/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : 127.0.0.1:3306
 Source Schema         : db_blog

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 03/05/2020 20:47:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin`  (
  `adminId` int(0) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `attribute` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `department` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` int(0) NULL DEFAULT NULL,
  `jobNumber` int(0) NULL DEFAULT NULL,
  `sex` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`adminId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog`  (
  `blogId` int(0) NOT NULL AUTO_INCREMENT,
  `userId` int(0) NOT NULL,
  `classId` int(0) NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `blogDate` datetime(0) NOT NULL,
  `blogContent_html` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `blogContent_md` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `browse` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `comment` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`blogId`) USING BTREE,
  INDEX `b_userId`(`userId`) USING BTREE,
  INDEX `b_classification`(`classId`) USING BTREE,
  CONSTRAINT `b_classification` FOREIGN KEY (`classId`) REFERENCES `t_classification` (`classId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `b_userId` FOREIGN KEY (`userId`) REFERENCES `t_user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_classification
-- ----------------------------
DROP TABLE IF EXISTS `t_classification`;
CREATE TABLE `t_classification`  (
  `classId` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `childName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`classId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `commentId` int(0) NOT NULL AUTO_INCREMENT,
  `userId` int(0) NOT NULL,
  `blogId` int(0) NULL DEFAULT NULL,
  `like` int(0) NULL DEFAULT NULL,
  `date` datetime(0) NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `rootId` int(0) NULL DEFAULT NULL,
  `dialogId` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`commentId`) USING BTREE,
  INDEX `c_userId`(`userId`) USING BTREE,
  INDEX `c_blog`(`blogId`) USING BTREE,
  CONSTRAINT `c_blog` FOREIGN KEY (`blogId`) REFERENCES `t_blog` (`blogId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `c_userId` FOREIGN KEY (`userId`) REFERENCES `t_user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_like
-- ----------------------------
DROP TABLE IF EXISTS `t_like`;
CREATE TABLE `t_like`  (
  `likeId` int(0) NOT NULL AUTO_INCREMENT,
  `userId` int(0) NOT NULL,
  `date` datetime(0) NOT NULL,
  `blogId` int(0) NULL DEFAULT NULL,
  `commentId` int(0) NULL DEFAULT NULL,
  `rootId` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`likeId`) USING BTREE,
  INDEX `l_blog`(`blogId`) USING BTREE,
  INDEX `l_comment`(`commentId`) USING BTREE,
  INDEX `l_userId`(`userId`) USING BTREE,
  INDEX `l_rootId`(`rootId`) USING BTREE,
  CONSTRAINT `l_blog` FOREIGN KEY (`blogId`) REFERENCES `t_blog` (`blogId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `l_comment` FOREIGN KEY (`commentId`) REFERENCES `t_comment` (`commentId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `l_rootId` FOREIGN KEY (`rootId`) REFERENCES `t_comment` (`commentId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `l_userId` FOREIGN KEY (`userId`) REFERENCES `t_user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_relationship
-- ----------------------------
DROP TABLE IF EXISTS `t_relationship`;
CREATE TABLE `t_relationship`  (
  `relationship_id` int(0) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user1` int(0) NULL DEFAULT NULL,
  `user2` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`relationship_id`) USING BTREE,
  INDEX `r_user1`(`user1`) USING BTREE,
  INDEX `r_user2`(`user2`) USING BTREE,
  CONSTRAINT `r_user1` FOREIGN KEY (`user1`) REFERENCES `t_user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `r_user2` FOREIGN KEY (`user2`) REFERENCES `t_user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `userId` int(0) NOT NULL AUTO_INCREMENT,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `userName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `occupation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` int(0) NULL DEFAULT NULL,
  `sex` int(0) NULL DEFAULT NULL,
  `attribute` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`userId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
