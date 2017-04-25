package com.security.entity;

import java.io.Serializable;
import javax.persistence.*;

import org.hibernate.validator.constraints.NotEmpty;

/**
 * @author zhaodongchao
 */
@Entity
@Table(name="CF_AUTHORITY")
public class Authority implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String authorityId;

    private String authorityName;

    private String operationUri;

    private String descriptions;

    private static final long serialVersionUID = 1L;

    public String getAuthorityId() {
        return authorityId;
    }

    public void setAuthorityId(String authorityId) {
        this.authorityId = authorityId;
    }

    public String getAuthorityName() {
        return authorityName;
    }

    public void setAuthorityName(String authorityName) {
        this.authorityName = authorityName;
    }

    public String getOperationUri() {
        return operationUri;
    }

    public void setOperationUri(String operationUri) {
        this.operationUri = operationUri;
    }

    public String getDescriptions() {
        return descriptions;
    }

    public void setDescriptions(String descriptions) {
        this.descriptions = descriptions;
    }
}