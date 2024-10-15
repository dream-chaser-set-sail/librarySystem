/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80037 (8.0.37)
 Source Host           : localhost:3306
 Source Schema         : library_system

 Target Server Type    : MySQL
 Target Server Version : 80037 (8.0.37)
 File Encoding         : 65001

 Date: 15/10/2024 13:40:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `admin_card_num` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '管理员编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `unit` int NOT NULL DEFAULT 2 COMMENT '单位',
  `status` int NOT NULL DEFAULT 1 COMMENT '状态: 0 停用 1 正常',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_card_num`(`admin_card_num` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, '80718444582', '张伟', '1', '82c938f416f74c5dab5fcf2847bd5705.jpeg', 2, 1, '2024-09-13 20:15:56');
INSERT INTO `admin` VALUES (2, '65591434939', '程霜', '1', 'e1ac2ea550e74ddc90301a212acea505.jpeg', 2, 1, '2024-09-17 09:18:24');

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '书表',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '书名',
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '书号',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者',
  `publishing_house` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出版社',
  `book_type` int NULL DEFAULT NULL COMMENT '书籍分类',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图片名',
  `price` double NOT NULL DEFAULT 0 COMMENT '价格',
  `amount` int NOT NULL DEFAULT 0 COMMENT '数量',
  `ontop` int NOT NULL DEFAULT 0 COMMENT '0 未置顶 1 已置顶',
  `onclick_num` int NOT NULL DEFAULT 0 COMMENT '借阅量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  `synopsis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '暂无' COMMENT '书籍简介',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '书表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '《追风筝的人》', '9781594480003', '卡勒德·胡赛尼', '花城出版社', 1, '4ba74fe3c159406ab5e3522d33855ba5.jpeg', 29.99, 10, 1, 36, '2024-09-17 10:46:56', '《追风筝的人》是卡勒德·胡赛尼创作的一部感人至深的小说，讲述了阿米尔和他的朋友哈桑之间复杂的友谊与背叛。故事发生在阿富汗，描绘了他们童年时快乐的放风筝时光，但随着政治动荡和个人选择，二人关系逐渐破裂。成年后的阿米尔回到战乱后的故乡，试图为过去的错误赎罪，并帮助哈桑的儿子。小说深刻探讨了友谊、悔恨和救赎，展现了人性中的善与恶。');
INSERT INTO `book` VALUES (2, '《小王子》', '9787544270874', '安托万·德·圣埃克苏佩里', '人民文学出版社', 1, 'little_prince.jpg', 18, 15, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (3, '《时间简史》', '9780553380163', '斯蒂芬·霍金', '未知出版社', 2, '0c140376a65b4d0c94dd5ac45cab018d.jpeg', 35.5, 7, 1, 1, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (4, '《编程珠玑》', '9780321193681', 'Jon Bentley', '电子工业出版社', 9, '944d13e91f50449383803ca4cca167ee.jpeg', 49.99, 5, 1, 80, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (5, '《活着》', '9787506365433', '余华', '作家出版社', 1, 'to_live.jpg', 22.5, 12, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (6, '《万历十五年》', '9787108027807', '黄仁宇', '中华书局', 2, 'wanli.jpg', 28, 7, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (7, '《人类简史》', '9780062316097', '尤瓦尔·赫拉利', '中信出版社', 2, 'sapiens.jpg', 38, 9, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (8, '《罪与罚》', '9787020021943', '陀思妥耶夫斯基', '译林出版社', 3, 'crime_and_punishment.jpg', 25, 6, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (9, '《极简主义》', '9787508641503', '乔舒亚·费尔兹', '现代出版社', 7, 'minimalism.jpg', 30, 11, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (10, '《未来简史》', '9780062464311', '尤瓦尔·赫拉利', '中信出版社', 2, 'homo_deus.jpg', 40, 13, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (11, '《情人》', '9787544273271', '玛格丽特·杜拉斯', '上海译文出版社', 1, 'lover.jpg', 27, 10, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (12, '《百年孤独》', '9780060883287', '加布里埃尔·加西亚·马尔克斯', '译林出版社', 1, 'one_hundred_years.jpg', 32, 8, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (13, '《摆渡人》', '9787505737025', '克劳斯', '北京联合出版公司', 1, 'ferry_man.jpg', 23.5, 10, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (14, '《简爱》', '9787020039733', '夏洛蒂·勃朗特', '译林出版社', 1, 'jane_eyre.jpg', 21, 9, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (15, '《看不见的城市》', '9787530215395', '伊塔洛·卡尔维诺', '南海出版公司', 1, 'invisible_cities.jpg', 26, 7, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (16, '《全球通史》', '9787208100316', '李约瑟', '上海人民出版社', 2, 'global_history.jpg', 55, 6, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (17, '《黑客与画家》', '9780596006621', '保罗·格雷厄姆', '机械工业出版社', 9, '82f418396d6942ddb30fb0f1391ef27c.jpeg', 47, 8, 1, 60, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (18, '《人类的群星闪耀时》', '9787506389723', '斯蒂芬·茨威格', '北京十月文艺出版社', 1, 'e8560c8868f44c7b93d3fcfed22de80b.jpeg', 29, 12, 1, 10, '2024-09-17 10:46:56', '《人类的群星闪耀时》是斯捷潘·茨威格创作的一部散文集，书中回顾了历史上几个关键时刻的伟大人物和事件。每篇文章都聚焦于特定的历史节点，探讨这些时刻对人类文明的深远影响。  茨威格通过生动的叙述和细腻的描写，描绘了如哥白尼、达·芬奇、拿破仑等历史名人的传奇经历，反思他们如何在关键时刻改变了历史的进程。这些故事不仅展示了个人的伟大，也反映了时代的变迁和人类精神的力量。  这部作品强调了历史的偶然性及其背后的复杂性，体现了茨威格对人性的深刻理解和对历史的敬畏。');
INSERT INTO `book` VALUES (19, '《无声告白》', '9787510426168', '伍绮诗', '新星出版社', 1, 'silent_care.jpg', 24.5, 11, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (20, '《从零开始学Python》', '9787115364792', '蔡志忠', '机械工业出版社', 9, 'python_begin.jpg', 40, 7, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (21, '《解忧杂货店》', '9787544276111', '东野圭吾', '译林出版社', 1, 'worry_store.jpg', 25, 13, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (22, '《无声的证言》', '9787510427868', '弗朗西斯·福山', '新星出版社', 1, 'silent_testimony.jpg', 22, 9, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (23, '《社会契约论》', '9787544277620', '让-雅克·卢梭', '中信出版社', 2, 'social_contract.jpg', 20, 11, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (24, '《迷人的特质》', '9787510430187', '本杰明·富兰克林', '新星出版社', 1, 'charming_qualities.jpg', 18, 10, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (25, '《龙文身的女孩》', '9787532739431', '斯蒂格·拉尔森', '译林出版社', 1, 'girl_with_dragon_tattoo.jpg', 27, 8, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (26, '《追忆似水年华》', '9787020050448', '马塞尔·普鲁斯特', '译林出版社', 3, 'remembrance.jpg', 35, 6, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (27, '《长恨歌》', '9787530212478', '白居易', '中华书局', 1, 'song_of_endless_sorrow.jpg', 23, 11, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (28, '《福尔摩斯探案全集》', '9787020028317', '阿瑟·柯南·道尔', '译林出版社', 1, 'sherlock_holmes.jpg', 55, 7, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (29, '《红楼梦》', '9787020000000', '曹雪芹', '人民文学出版社', 1, 'dream_of_red_mansions.jpg', 40, 6, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (30, '《逻辑思维》', '9787510427456', '罗振宇', '新星出版社', 7, 'logical_thinking.jpg', 27, 8, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (31, '《思考，快与慢》', '9780141033570', '丹尼尔·卡尼曼', '中信出版社', 2, 'thinking_fast_and_slow.jpg', 42, 10, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (32, '《成为》', '9780399592522', '米歇尔·奥巴马', '皇冠出版社', 1, 'becoming.jpg', 30, 12, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (33, '《异类：不一样的成功启示录》', '9787550286228', '马尔科姆·格拉德威尔', '北京联合出版公司', 2, 'outliers.jpg', 35, 8, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (34, '《流浪地球》', '9787229142112', '刘慈欣', '人民文学出版社', 1, 'wandering_earth.jpg', 25, 15, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (35, '《我们仨》', '9787513328804', '杨绛', '生活·读书·新知三联书店', 1, 'we_three.jpg', 28, 10, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (36, '《天才在左，疯子在右》', '9787506377999', '高铭', '中国友谊出版公司', 3, 'genius_or_madness.jpg', 22, 9, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (37, '《老人与海》', '9780130281090', '欧内斯特·海明威', '译林出版社', 1, 'old_man_and_the_sea.jpg', 19, 14, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (38, '《牛津通识读本：西方哲学史》', '9780198735306', '安东尼·肯尼', '牛津大学出版社', 2, 'oxford_philosophy.jpg', 27, 7, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (39, '《你当像鸟飞往你的山》', '9787508640124', '塔拉·韦斯特弗', '北京联合出版公司', 1, 'educated.jpg', 31, 11, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (40, '《深夜小狗神秘事件》', '9780062330345', '马克·哈登', '华文出版社', 1, 'curious_incident.jpg', 23, 13, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (41, '《羊脂球》', '9787020036884', '莫泊桑', '人民文学出版社', 1, 'ball_of_sheep.jpg', 21, 12, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (42, '《被讨厌的勇气》', '9787229132595', '岸见一郎', '北京联合出版公司', 1, 'courage_to_be_disliked.jpg', 29, 10, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (43, '《你是最好的自己》', '9787505684718', '李尚龙', '人民文学出版社', 1, 'best_you.jpg', 32, 9, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (44, '《好好说话》', '9787508676391', '李开复', '中信出版社', 7, 'speak_well.jpg', 30, 11, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (45, '《我与地坛》', '9787506375100', '史铁生', '作家出版社', 1, 'temple_of_earth.jpg', 22, 14, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (46, '《长江图》', '9787530219477', '阎连科', '作家出版社', 1, 'yangtze_river.jpg', 28, 10, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (47, '《围城》', '9787020031307', '钱钟书', '人民文学出版社', 1, '围城.jpg', 25, 8, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (48, '《一九八四》', '9780547249643', '乔治·奥威尔', '译林出版社', 3, '1984.jpg', 20, 12, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (49, '《金瓶梅》', '9787544286616', '兰陵笑笑生', '中华书局', 1, 'jin_ping_mei.jpg', 40, 6, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (50, '《罗生门》', '9787544295632', '芥川龙之介', '人民文学出版社', 1, 'ro_shen_men.jpg', 22, 11, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (51, '《刀锋》', '9787229142251', '毛姆', '北京联合出版公司', 1, 'razor_edge.jpg', 31, 8, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (52, '《巴黎圣母院》', '9787020027038', '维克多·雨果', '人民文学出版社', 1, 'notre_dame.jpg', 30, 7, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (53, '《福尔摩斯探案集》', '9787020034780', '阿瑟·柯南·道尔', '译林出版社', 1, 'holmes_cases.jpg', 35, 9, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (54, '《余华小说三部曲》', '9787506375582', '余华', '作家出版社', 1, 'yu_hua_trilogy.jpg', 50, 6, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (55, '《倾城之恋》', '9787530217391', '张爱玲', '作家出版社', 1, 'city_of_sadness.jpg', 27, 11, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (56, '《动物农场》', '9780141182704', '乔治·奥威尔', '企鹅图书', 3, 'animal_farm.jpg', 20, 14, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (57, '《恶意》', '9787530217780', '东野圭吾', '译林出版社', 1, 'malice.jpg', 23, 10, 0, 0, '2024-09-17 10:46:56', '暂无');
INSERT INTO `book` VALUES (58, '《了不起的盖茨比》', '9780743273565', 'F·斯科特·菲茨杰拉德', '企鹅图书', 1, 'great_gatsby.jpg', 22, 13, 0, 0, '2024-09-17 10:46:56', '暂无');

-- ----------------------------
-- Table structure for book_classify
-- ----------------------------
DROP TABLE IF EXISTS `book_classify`;
CREATE TABLE `book_classify`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类名',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '书籍标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_classify
-- ----------------------------
INSERT INTO `book_classify` VALUES (2, '儿童文学');
INSERT INTO `book_classify` VALUES (10, '历史');
INSERT INTO `book_classify` VALUES (5, '反乌托邦');
INSERT INTO `book_classify` VALUES (3, '古典文学');
INSERT INTO `book_classify` VALUES (7, '哲学');
INSERT INTO `book_classify` VALUES (1, '小说');
INSERT INTO `book_classify` VALUES (11, '工具书');
INSERT INTO `book_classify` VALUES (14, '心理学');
INSERT INTO `book_classify` VALUES (15, '推理');
INSERT INTO `book_classify` VALUES (17, '散文');
INSERT INTO `book_classify` VALUES (6, '爱情');
INSERT INTO `book_classify` VALUES (12, '科学');
INSERT INTO `book_classify` VALUES (8, '科幻');
INSERT INTO `book_classify` VALUES (13, '经济学');
INSERT INTO `book_classify` VALUES (9, '计算机');
INSERT INTO `book_classify` VALUES (16, '财商');
INSERT INTO `book_classify` VALUES (4, '魔幻现实主义');

-- ----------------------------
-- Table structure for borrow_books
-- ----------------------------
DROP TABLE IF EXISTS `borrow_books`;
CREATE TABLE `borrow_books`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '借书表',
  `isbn` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '书号',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '借书时间',
  `endTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '-' COMMENT '还书时间',
  `status` int NOT NULL DEFAULT 2 COMMENT '借阅状态',
  `borrow_card_num` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '卡号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '借书表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrow_books
-- ----------------------------
INSERT INTO `borrow_books` VALUES (1, '9781594480003', '2024-09-17 11:00:10', '2024-10-6 01:38:11', 2, '65591434939');
INSERT INTO `borrow_books` VALUES (2, '9787506389723', '2024-09-17 14:45:30', '2024-10-04 13:30:57', 1, '65591434939');
INSERT INTO `borrow_books` VALUES (3, '9780553380163', '2024-10-03 15:10:14', '2024-10-5 23:31:17', 2, '65591434939');
INSERT INTO `borrow_books` VALUES (11, '9780321193681', '2024-10-03 15:41:39', '2024-10-04 13:30:56', 1, '65591434939');
INSERT INTO `borrow_books` VALUES (12, '9780596006621', '2024-10-03 16:05:46', '2024-10-04 13:30:57', 1, '65591434939');

-- ----------------------------
-- Table structure for borrow_cards
-- ----------------------------
DROP TABLE IF EXISTS `borrow_cards`;
CREATE TABLE `borrow_cards`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `borrow_card_num` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '卡号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `unit` int NOT NULL DEFAULT 1 COMMENT '单位',
  `role` int NOT NULL DEFAULT 3 COMMENT '身份: 1: 教师 2: 学生 3: 其他人员 4: 管理员',
  `status` int NOT NULL DEFAULT 1 COMMENT '1 未借阅 2 已借阅 3 逾期',
  `permission` int NULL DEFAULT 1 COMMENT '权限',
  `borrowed_books_num` int NOT NULL DEFAULT 0 COMMENT '借书数量',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `credit_score` int NOT NULL DEFAULT 100 COMMENT '信誉',
  `admin_status` int NOT NULL DEFAULT 0 COMMENT '是否授权管理/管理状态是否禁用(0 否 1 是)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `borrow_card_num`(`borrow_card_num` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '借书卡表(用户表)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrow_cards
-- ----------------------------
INSERT INTO `borrow_cards` VALUES (1, '65591434939', '程霜', 'e1ac2ea550e74ddc90301a212acea505.jpeg', 3, 1, 2, 10, 2, '2024-09-27 21:07:36', 100, 1);
INSERT INTO `borrow_cards` VALUES (2, '80718444582', '张伟', '82c938f416f74c5dab5fcf2847bd5705.jpeg', 3, 2, 1, 1, 0, '2024-09-27 21:09:06', 100, 1);

-- ----------------------------
-- Table structure for countday
-- ----------------------------
DROP TABLE IF EXISTS `countday`;
CREATE TABLE `countday`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '计算天数表',
  `isbn` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '书号',
  `createTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '借书天数',
  `nowTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '当前天数',
  `endTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '还书天数',
  `borrow_card_num` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '卡号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of countday
-- ----------------------------

-- ----------------------------
-- Table structure for credit
-- ----------------------------
DROP TABLE IF EXISTS `credit`;
CREATE TABLE `credit`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '信誉表',
  `borrow_card_num` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '卡号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '信誉表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of credit
-- ----------------------------

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '单位表',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '系名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '单位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '无');
INSERT INTO `department` VALUES (2, '图书馆');
INSERT INTO `department` VALUES (3, '计算机科学与技术系');
INSERT INTO `department` VALUES (4, '电子工程系');
INSERT INTO `department` VALUES (5, '物理学院');
INSERT INTO `department` VALUES (6, '生物科学系');
INSERT INTO `department` VALUES (7, '化学工程系');
INSERT INTO `department` VALUES (8, '数学与应用数学系');
INSERT INTO `department` VALUES (9, '社会学系');
INSERT INTO `department` VALUES (10, '经济学系');
INSERT INTO `department` VALUES (11, '法学院');
INSERT INTO `department` VALUES (12, '环境科学系');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '身份表',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '身份表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, '教师');
INSERT INTO `roles` VALUES (2, '学生');
INSERT INTO `roles` VALUES (3, '其他人员');
INSERT INTO `roles` VALUES (4, '管理员');

-- ----------------------------
-- Table structure for status
-- ----------------------------
DROP TABLE IF EXISTS `status`;
CREATE TABLE `status`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of status
-- ----------------------------
INSERT INTO `status` VALUES (1, '未借阅');
INSERT INTO `status` VALUES (2, '已借阅');
INSERT INTO `status` VALUES (3, '逾期');

-- ----------------------------
-- Triggers structure for table borrow_cards
-- ----------------------------
DROP TRIGGER IF EXISTS `set_default_permission`;
delimiter ;;
CREATE TRIGGER `set_default_permission` BEFORE INSERT ON `borrow_cards` FOR EACH ROW BEGIN
  IF NEW.role = 1 THEN
    SET NEW.permission = 10;
  ELSEIF NEW.role = 2 THEN
    SET NEW.permission = 5;
  ELSE
    SET NEW.permission = 1; -- 默认值
  END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
