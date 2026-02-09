## 更换引导卷
- 选中实例
- 存储 - 替换引导卷 - [ubuntu-2404](https://docs.oracle.com/en-us/iaas/images/ubuntu-2404/)

1.  替换方式：映像
2.  引导卷方式：ocid
3. 高级选项 - 元数据 名称`ssh_authorized_keys`，值为公共密钥
```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrP+T3rUfNScGAny+jASRD/HcF0Onnnj8LR1kDBnes32lWw9a7uDehfylw1gq/N4k6iE2IWVdnVLfLa4dtt9/nusDh0xAmnv9exLppe2lytSGDh4hJtoUoXlq4RDwj63VPOC7j1lKYte6/maiSpyUjlJA8aiNHTBXcryD2M154wm8vmSbB/X1g0ysBvk4uVpF1rmiX29J8f4FdaIcHAi2/+IS26I5P7RWruNvPE9jehaK25oCiMdeJGs9eKcLFVLSN+xwLagSUP6kFu0SCEFsCoChh5bq2haeWRhcchpaiKD1Y0sJAtaNc/H0c5O1Lhra4mcN4skM+Gih0ueg/RF3vez4A6C2GLKapjL9ambLYqc9Ig4Rsm3oZ/eKnzZe6RXdWFW70fjD6RXx+IDgDd7St95caS0ptTvos14ZsL6fCvGYCwkLLQxzUz93nQ4tiZlyMf44dwhUK6G/9yEAAo3Ug5yBdSvGm+fonXuZVHfWGQNDudM8mGIgnTaD7p90DLK1IxzfU3xdSlbeW2XdE1Je36VBidkjqoZhSKFLYT7EZ33SVdo25TkmcIHuf4zN2wEGg5V4pf22J5kqSBpNFvFujxLOcwY7axD/+CqJDR3QbLIdmLcEHYusyUSW4YlYPp6lu5clh8pDoC/21yhlByQob83qqUJlu9vaOekgw4Pob3w== longan@longandeMacBook-Pro.local
```
4. 私有密钥 mac mini上的`.ssh/ssh-amsterdam.key`,mbp 2018上好像在`~`